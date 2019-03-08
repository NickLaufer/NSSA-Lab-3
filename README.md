# Network Security & System Audit
Tool set for Lab 3:

## *PingSweep:*

PingSweep is a Powershell script than enumerates through IP addresses on a network.
IP Addresses must be located on the same network.

## *DNSEnumeration:*

DNSEnumeration is a Powershell script that enumerates through a given text file and resolves the hostnames within that file. The script uses the Resolve-DnsName commandlet to resolve the hostnames to IP addresses.

## *OSClassification:*

OSClassification is a Python script that, through a given text file containing a list of IP addresses, performs OS fingerprinting/detection by using the Time To Live (TTL) values of popular operating systems.
