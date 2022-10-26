$connectedNetworkAdapters = Get-CimInstance win32_networkadapter -filter "netconnectionstatus = 2" | Select-Object netconnectionid

foreach ($netconnectionid in $connectedNetworkAdapters.netconnectionid)
{
  Write-Host "${netconnectionid}" -ForegroundColor Blue
  Write-Host "$((Get-NetIPAddress -InterfaceAlias ${netconnectionid}).IPv4Address)`n" -ForegroundColor White
}

try
{
	$publicip = $((Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)
	if ($publicip)
	{
		Write-Host "Public IP" -ForegroundColor Red
		Write-Host $publicip -ForegroundColor White
	}
	else
	{
		Write-Host "Error retrieving public ip" -ForegroundColor Red
	}	
}
catch
{
	Write-Host "No Internet connection" -ForegroundColor Red
}
