#!/bin/bash
#PortScanning.sh
#Scan a range of IPs and ports to see if they are open
#CSEC-465 Lab 3 - Brian Bullis

#IP address validation
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

#enter starting address and validate it
echo "Enter the starting IP address (ex: 10.0.0.1) "
read startIP

if valid_ip $startIP;
then
:
else
	echo "Invalid IP $startIP entered. Please try again."
	exit 0
fi

#enter ending address and validate it
echo "Enter the ending IP address (ex: 10.0.0.2) "
read endIP

if valid_ip $endIP;
then
:
else
	echo "Invalid IP $endIP entered. Please try again."
	exit 0
fi

#enter starting port and validate it
echo "Enter the starting port (ex: 80) "
read startPort

if [[ $startPort -ge 1 && $startPort -le 65535 ]];
then
:
else
	echo "Invalid port $startPort entered. Please try again."
	exit 0
fi

#enter ending port and validate it
echo "Enter the ending port (ex: 443) "
read endPort

if [[ $endPort -ge 1 && $endPort -le 65535 ]];
then
:
else
	echo "Invalid port $endPort entered. Please try again."
	exit 0
fi

#split the start and end addresses into arrays so the octets can be iterated
IFS='.' read -ra splitStart <<< "$startIP"
IFS='.' read -ra splitEnd <<< "$endIP"

#iterate throuh addresses and ports and make a nc connection
for ((firstOctet=${splitStart[0]};firstOctet<=${splitEnd[0]};firstOctet++))
	do
	for ((secondOctet=${splitStart[1]};secondOctet<=${splitEnd[1]};secondOctet++))
		do
		for ((thirdOctet=${splitStart[2]};thirdOctet<=${splitEnd[2]};thirdOctet++))
			do
			for ((fourthOctet=${splitStart[3]};fourthOctet<=${splitEnd[3]};fourthOctet++))
				do
				for ((portNum=$startPort;portNum<=$endPort;portNum++))
					do
					(echo > /dev/tcp/$firstOctet.$secondOctet.$thirdOctet.$fourthOctet/$portNum) &>/dev/null
    					[ $? -eq 0 ] && echo "$firstOctet.$secondOctet.$thirdOctet.$fourthOctet:$portNum open" || echo "$firstOctet.$secondOctet.$thirdOctet.$fourthOctet:$portNum closed"
					done
				done
			done
		done
	done

exit 0
