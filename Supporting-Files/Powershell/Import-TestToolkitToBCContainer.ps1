############################################################################################################
# Set these values
$containername = 'BC24'
############################################################################################################

$scriptTitle = 'Import-TestToolkitToBCContainer'

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

Import-TestToolkitToBCContainer -containerName $containerName

$stopTime = [DateTime]::Now
$timeSpend = ($stopTime -$startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timeSpend) seconds"