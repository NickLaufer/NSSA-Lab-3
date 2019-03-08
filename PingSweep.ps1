"IP Ping Sweeper 1.0"
"-------------------"
$Start = Read-Host -Prompt "Enter the starting IP address (ex: 10.0.0.1)"
try{
    $length = $Start.length
    $index = $Start.LastIndexOf(".") + 1
    $startstring = $length - $index
    $Startcounter = $Start.substring($index, $startstring)
    $Startip = $Start
    $Start = [ipaddress]$Start
}
catch
{
    "Error: Starting IP Address was incorrectly entered. Please double check and try again."
}
$End = Read-Host -Prompt "Enter the ending IP address (ex: 10.0.0.2)"
try{
    $endindex = $End.LastIndexOf(".") + 1
    $endlength = $End.length
    $endstring = $length - $endindex
    $Endcounter = $End.Substring($endindex, $endstring)
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
    $ip = $ip.remove($index, $startstring).insert($index, $a)
    $result = Test-Connection $ip -Quiet -Count 1
    if($result -eq $false){
        Write-Host "$ip is unreachable."
    }
    else{
        Write-Host "$ip is up!"
    }
    $a++
}




