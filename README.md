# NetworkEnum.sh
Network protocol analysis script for Kali Linux
<br />
# Instructions
1. Install dependencies <br />
2. Run setup (Option 1), this is not persistent so you will need to reenter it each time you run the script. <br />
3. choose Unauth Network Info Gather or  TCPDump and parse to begin with. All output is displayed and files saved in the local folder. <br />

<br />
# Example

```
$ sudo ./NetworkEnum.sh                        

Network Enumeration and Testing
You are root.
Menu:
0. Setup
1. Unauth Network Info Gather
2. TCPDump and parse
3. Exit
Enter your choice: 0
Setup
Enter target file location: ./targets.txt
[+]Target file saved.
Enter domain name: testtest.test
You are root.
Menu:
0. Setup
1. Unauth Network Info Gather
2. TCPDump and parse
3. Exit
Enter your choice: 0
Setup
Enter target file location: ./targets.txt
[+]Target file saved.
Enter domain name: testtest.test
You are root.
Menu:
0. Setup
1. Unauth Network Info Gather
2. TCPDump and parse
3. Exit
Enter your choice: Enter your choice: 0
Setup
Enter target file location: ./targets.txt
[+]Target file saved.
Enter domain name: testtest.test
You are root.
Menu:
0. Setup
1. Unauth Network Info Gather
2. TCPDump and parse
3. Exit
Enter your choice: 1
Unauth Network Info Gather 

Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-01-02 20:02 CST
Nmap scan report for localhost (127.0.0.1)
Host is up.
Nmap done: 1 IP address (1 host up) scanned in 0.00 seconds
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Warning: You specified a highly aggressive --min-hostgroup.
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-01-02 20:02 CST
Initiating SYN Stealth Scan at 20:02
Scanning localhost (127.0.0.1) [50 ports]
Completed SYN Stealth Scan at 20:02, 0.02s elapsed (50 total ports)
Nmap scan report for localhost (127.0.0.1)
Host is up, received user-set (0.0000010s latency).
Scanned at 2025-01-02 20:02:01 CST for 0s

PORT      STATE  SERVICE          REASON
21/tcp    closed ftp              reset ttl 64
22/tcp    closed ssh              reset ttl 64
23/tcp    closed telnet           reset ttl 64
25/tcp    closed smtp             reset ttl 64
26/tcp    closed rsftp            reset ttl 64
53/tcp    closed domain           reset ttl 64
80/tcp    closed http             reset ttl 64
81/tcp    closed hosts2-ns        reset ttl 64
110/tcp   closed pop3             reset ttl 64
111/tcp   closed rpcbind          reset ttl 64
113/tcp   closed ident            reset ttl 64
137/tcp   closed netbios-ns       reset ttl 64
139/tcp   closed netbios-ssn      reset ttl 64
143/tcp   closed imap             reset ttl 64
179/tcp   closed bgp              reset ttl 64
199/tcp   closed smux             reset ttl 64
443/tcp   closed https            reset ttl 64
445/tcp   closed microsoft-ds     reset ttl 64
465/tcp   closed smtps            reset ttl 64
514/tcp   closed shell            reset ttl 64
515/tcp   closed printer          reset ttl 64
548/tcp   closed afp              reset ttl 64
554/tcp   closed rtsp             reset ttl 64
587/tcp   closed submission       reset ttl 64
646/tcp   closed ldp              reset ttl 64
993/tcp   closed imaps            reset ttl 64
995/tcp   closed pop3s            reset ttl 64
1025/tcp  closed NFS-or-IIS       reset ttl 64
1026/tcp  closed LSA-or-nterm     reset ttl 64
1027/tcp  closed IIS              reset ttl 64
1433/tcp  closed ms-sql-s         reset ttl 64
1720/tcp  closed h323q931         reset ttl 64
1723/tcp  closed pptp             reset ttl 64
2000/tcp  closed cisco-sccp       reset ttl 64
2001/tcp  closed dc               reset ttl 64
3306/tcp  closed mysql            reset ttl 64
3389/tcp  closed ms-wbt-server    reset ttl 64
5060/tcp  closed sip              reset ttl 64
5666/tcp  closed nrpe             reset ttl 64
5900/tcp  closed vnc              reset ttl 64
6001/tcp  closed X11:1            reset ttl 64
8000/tcp  closed http-alt         reset ttl 64
8008/tcp  closed http             reset ttl 64
8080/tcp  closed http-proxy       reset ttl 64
8443/tcp  closed https-alt        reset ttl 64
8888/tcp  closed sun-answerbook   reset ttl 64
10000/tcp closed snet-sensor-mgmt reset ttl 64
32768/tcp closed filenet-tms      reset ttl 64
49152/tcp closed unknown          reset ttl 64
49154/tcp closed unknown          reset ttl 64

Read data files from: /usr/share/nmap
Nmap done: 1 IP address (1 host up) scanned in 0.08 seconds
           Raw packets sent: 50 (2.200KB) | Rcvd: 100 (4.200KB)
Warning: You specified a highly aggressive --min-hostgroup.
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-01-02 20:02 CST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000056s latency).

PORT     STATE  SERVICE
53/udp   closed domain
69/udp   closed tftp
111/udp  closed rpcbind
123/udp  closed ntp
161/udp  closed snmp
514/udp  closed syslog
1900/udp closed upnp

Nmap done: 1 IP address (1 host up) scanned in 0.12 seconds
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-01-02 20:02 CST
Nmap scan report for localhost (127.0.0.1)
Nmap done: 1 IP address (0 hosts up) scanned in 0.00 seconds
testtest.test
[*] std: Performing General Enumeration against: testtest.test...
```
