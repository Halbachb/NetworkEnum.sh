#!/usr/bin/env bash

cat ./carl-logo2.txt
if [ -e "./carl-logo2.txt" ]; then
    cat ./carl-logo2.txt
else
    echo "Network Enumeration Tool."
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "Network Enumeration and Testing"

# bool function to test if the user is root or not (POSIX only)
is_user_root ()
{
    [ "$(id -u)" -eq 0 ]
}
function Menu() {

#Check if running as root before showing the menu
if is_user_root; then
    # echo 'You are the almighty root!'
    echo -e "${GREEN}You are root.${NC}" 
   # You can do whatever you need...
else
	#echo -e "${RED}This is red text${NC}"
	
	echo -e "${RED}[-] Not running as root, this could cause issues.${NC}" >&2
    	exit 1
fi

#Display Menu
echo "Menu:"
echo "0. Setup"
echo "1. Unauth Network Info Gather"
echo "2. TCPDump and parse"
echo "3. Exit"
read -p "Enter your choice: " choice

}
function ping_scan(){

	#Create unique Nmap output filename
	      
	filename="Client_pingscan-`date +"%d-%m-%Y-%h-%H-%M-%S"`"

	nmap -sP -PE -iL $1 -oA $filename
}
function tcp_discovery_scan() {


	filename="Client_tcp_discovery-`date +"%d-%m-%Y-%h-%H-%M-%S"`"
	
	nmap -vv -sS -Pn -T4 --min-hostgroup 128 --max-retries 0 -p 21,22,23,25,26,53,80,81,110,111,113,137,139,143,179,199,443,445,465,514,515,548,554,587,646,993,995,1025,1026,1027,1433,1720,1723,2000,2001,3306,3389,5060,5666,5900,6001,8000,8008,8080,8443,8888,10000,32768,49152,49154 -iL $1 -oA $filename 

}

function udp_discovery_scan(){

	
	filename="Client_udp_discovery-`date +"%d-%m-%Y-%h-%H-%M-%S"`"
	nmap -sU -Pn -min-hostgroup 128 -p53,69,123,161,111,514,1900  -iL $1 -oA $filename
}

function reverse_dns_scan(){

	filename="Client_rdns-`date +"%d-%m-%Y-%h-%H-%M-%S"`"
	nmap -sL -iL $1 -oA $filename
}

function dns_zone_transfer(){
	echo $1
	filename="Client_zone_transfer-`date +"%d-%m-%Y-%h-%H-%M-%S"`.xml"
	dnsrecon -d $1 -a --xml $filename
}

#create function to do the beginning of unauth network info gather
function unauth_network_info_gather() {

	ping_scan $1
	tcp_discovery_scan $1
	udp_discovery_scan $1
	reverse_dns_scan $1
	dns_zone_transfer $domainName

}


#Parse protocols from TCPDump
function parse_protocols(){
	
	#echo "Command:  tshark -r $i -Y hsrp -T fields -e hsrp.auth_data -e hsrp.version -e hsrp.priority -e hsrp.auth_data -e hsrp.virt_ip"

	#parse hsrp
	echo "HSRP Information"
	echo "****************"
	tshark -r $1 -Y hsrp -T fields -e hsrp.auth_data -e hsrp.version -e hsrp.priority -e hsrp.auth_data -e hsrp.virt_ip | head
	

	#parse ospf
	echo "OSPF Information"
	echo "****************"
	tshark -r $1 -Y ospf -T fields -e ospf.msg -e ospf.area_id -e ospf.auth.type -e ospf.at.auth_data -e ospf.hello.router_priority | head

	#parse CDP
	echo "CDP Information"
	echo "***************"
	tshark -r $1 -Y cdp -T fields -e cdp.software_version -e cdp.version -e cdp.voice_vlan -e cdp.vtp_management_domain | head


	#parse LLDP
	echo "LLDP Information"
	echo "****************"
	tshark -r $1 -Y lldp -T fields -e lldp.chassis.id.ip4 -e lldp.chassis.id

	#parse VRRP
	echo "VRRP Information"
	echo "****************"
	tshark -r $1 -Y vrrp -T fields -e vrrp.prio -e vrrp.auth_type -e vrrp.auth_string
}


#Get the interface and run TCPDump

function TCPDump() {

	#Request the interface to capture on

	interface="eth0"
	read -p "Use eth0? [Y/n] " yn
	case $yn in
		[Yy]* ) if [ -z "$yn"  ]; then 
			interface="eth0"
			echo "using eth0"
			fi ;;
		[Nn]* ) read -p "Enter interface: " interface;;
		*) echo "invalid response";;
	esac

	#Get lenght of time to perform packet capture
	read -p "Enter capture time length in seconds (greater than 30 less than 900): " tcpDumpTime


	filename="TCPDump-`date +"%d-%m-%Y-%h-%H-%M-%S"`.pcap"	


	#run the dump ond you can combine -G {sec} (rotate dump files every x seconds) and -W {count} (limit # of dump files) to get what you want:
	echo "Command: tcpdump -G $tcpDumpTime -W1 -w $filename -i $interface" 
	tcpdump -G $tcpDumpTime -W 1 -w $filename -i $interface
	
	parse_protocols $filename
}

#Loop to show the menu and make choices

while true;do 
	Menu
	case $choice in
		0)
			echo "Setup"
			read -p "Enter target file location: " targetFile
			if [ -f $targetFile ]; then
				echo "[+]Target file saved."
				#echo $targetFile
			else
				echo "[-] Target file not found."
				#echo $targetFile
			fi
			read -p "Enter domain name: " domainName
			;;
		1) 
			echo "Unauth Network Info Gather "
			echo ""

			if [ -z "${targetFile}" ];then	
			#read -p "Enter target file location: " targetFile
			
			read -p $'\e[31m[+] Enter target file location\e[0m: ' targetFile
			echo ""
			fi
			unauth_network_info_gather $targetFile
			;;
		2) 
			echo "TCPDump"
			#echo""
			TCPDump
			;;
		3)
			echo "Exit"
			echo ""
			break
			;;
		*)
			echo "Choice Not Recognized"
			echo ""
			;;
		esac
	done
