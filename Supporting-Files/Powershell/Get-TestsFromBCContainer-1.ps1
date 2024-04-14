############################################################################################################
# Set these values
$containerName = 'BC24'
$testSuite = 'DEFAULT'
$userName = 'admin'
$password = 'password'
############################################################################################################

$scriptTitle = 'Get-TestsFromBCContainer Pipeline'

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($userName,$securePassword)

Get-TestsFromBCContainer `
    -containerName $containerName `
    -Credential $credential `
    -testSuite  $testSuite `
    -ignoreGroups

$stopTime = [DateTime]::Now
$timeSpend = ($stopTime -$startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timeSpend) seconds"