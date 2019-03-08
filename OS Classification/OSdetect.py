'''
This tool performs OS fingerprinting/detection by using the Time To Live (TTL) values of popular operating systems.
Designed for use with a Windows workstation.
'''

from subprocess import Popen, PIPE

IPlist = open("ips.txt")

for IP in IPlist:
    # ping with 1 request and 100ms timeout (in the interest of time)
    ping = Popen(['ping', '-n', '1', '-w', '100', IP.strip(' \t\n\r')], stdout=PIPE)
    output = str(ping.communicate()[0])
    TTLstart = output.find("TTL=")
    TTLend = output.find("Ping statistics")
    IPstart = output.find("Pinging")
    IPend = output.find(" with 32")
    hostAlive=ping.returncode
    if hostAlive == 0:  # only list IPs that are up
        TTL = int(''.join(filter(str.isdigit, output[TTLstart:TTLend]))) # get TTL value
        if 98 <= TTL <= 158:
            print(output[IPstart+8:IPend] + " | OS likely Windows")
        if 34 <= TTL <= 94:
            print(output[IPstart+8:IPend] + " | OS likely Linux/Unix")
