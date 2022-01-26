
function Get-forcepoint($tool) {

    if ($tool -eq 'forcepoint'){
    $forcepoint = ('idboiwdlp001.unfi.com' )
    $ports = ('443')
    Start-Sleep -Seconds 1
    Write-Host "" 
    Write-Host " #### Verify Hostname has access to DNS #### " -ForegroundColor Black -BackgroundColor white
    Write-Host "" 
    nslookup.exe $(hostname)
    Start-Sleep -Seconds 2
    

    ForEach ($ip in $forcepoint)
    {
    Write-Host ""
    Write-Host " ##################################### " -ForegroundColor Yellow
    Write-Host "   Analyzing $ip" -ForegroundColor red
    Write-Host " ##################################### " -ForegroundColor Yellow
    Write-Host "" 
    Write-Host "" 
    Write-Host " #### Testing Time to Reach $ip #### " -ForegroundColor Black -BackgroundColor white
    Write-Host ""
    Start-Sleep -Seconds 1
    Test-Connection -ComputerName $ip -Count 4 | Select-Object PSComputerName, Address, IPV4Address, ResponseTime
    Write-Host ""
    Start-Sleep -Seconds 1
    Write-Host " #### Test Connection to $ip & $ports #### " -ForegroundColor Black -BackgroundColor white
    Write-Host ""
    Start-Sleep -Seconds 5
    Test-NetConnection -ComputerName $ip -Port $ports | findstr TcpTestSucceeded
    Start-Sleep -Seconds 5
    Write-Host ""
    Write-Host " #### TraceRoute to $ip #### " -ForegroundColor Black -BackgroundColor white
    Write-Host ""
    Test-NetConnection -traceroute -ComputerName $ip | Select-Object -ExpandProperty TraceRoute
    Start-Sleep -Seconds 10
    }
    
    
}
    else {  
    Write-Host "No forcepoint"
    }
    Write-Host ""
    Write-Host " ##################################### " -ForegroundColor Green
    Write-Host "           Report Finished "  -ForegroundColor Green
    Write-Host " ##################################### " -ForegroundColor Green
}
Get-forcepoint(Read-Host -Prompt "Pick tool")
