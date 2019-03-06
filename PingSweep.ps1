"IP Ping Sweeper 1.0"
"-------------------"
$Start = Read-Host -Prompt "Enter the starting IP address (ex: 10.0.0.1)"
try{
    $length = $Start.length
    $startstring = $length - 7
    $Startcounter = $Start.substring(7,$startstring)
    $Startip = $Start
    $Start = [ipaddress]$Start
}
catch
{
    "Error: Starting IP Address was incorrectly entered. Please double check and try again."
}
$End = Read-Host -Prompt "Enter the ending IP address (ex: 10.0.0.2)"
try{
    $endlength = $End.length
    $endstring = $length - 7
    $Endcounter = $End.Substring(7, $endstring)
    $End = [ipaddress]$End
}
catch
{
    "Error: Ending IP Address was incorrectly entered. Please double check and try again."
}
If($End.Address -le $Start.Address){
    "Error: Ending IP Address is lower than starting IP address. Please try again."
}

$a = [int] $startcounter
$b = [int] $endcounter
$ip = $startip
While ($a -le $b){
    $ip = $ip.remove(7, $endstring).insert(7, $a)
    $result = Test-Connection $ip -Quiet -Count 1
    if($result -eq $false){
        Write-Host "$ip is unreachable."
    }
    else{
        Write-Host "$ip is up!"
    }
    $a++
}




