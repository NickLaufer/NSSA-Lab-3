# DNS Enumeration Script
# By Nick Laufer

foreach($line in Get-Content ./hosts.txt){
    try{
        $DnsRecord = Resolve-DnsName $line -Type A -DNSOnly | Select Name, Namehost, IP4Address
    }
    catch{
        Write-Host "Hostname $line could not be resolved."
    }
    Foreach($line in $DnsRecord){
        $line
    }
}