#!/usr/bin/env bash

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
echo "1. Network Recon"
echo "2. TCPDump"
echo "3. Exit"
read -p "Enter your choice: " choice

}
#Parse protocols from TCPDump
function parse_protocols(){
	
	#echo "Command:  tshark -r $i -Y hsrp -T fields -e hsrp.auth_data -e hsrp.version -e hsrp.priority -e hsrp.auth_data -e hsrp.virt_ip"


	tshark -r $1 -Y hsrp -T fields -e hsrp.auth_data -e hsrp.version -e hsrp.priority -e hsrp.auth_data -e hsrp.virt_ip | head

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
				echo "Target file not found."
				#echo $targetFile
			fi
			;;
		1) 
			echo "network recon"
			echo ""
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
