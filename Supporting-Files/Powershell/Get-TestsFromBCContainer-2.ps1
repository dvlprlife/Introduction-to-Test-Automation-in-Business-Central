############################################################################################################
# Set these values
$containerName = 'BC'
$testSuite = 'DEFAULT'
$userName = 'admin'
$password = 'password'
############################################################################################################

$scriptTitle = 'Get-TestsFromBCContainer'

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($userName,$securePassword)

$tests = Get-TestsFromBCContainer `
    -containerName $containerName `
    -Credential $credential `
    -testSuite  $testSuite `
    -ignoreGroups

foreach( $test in $tests) {
    Write-Host -ForegroundColor Yellow $tests.Id $tests.Name
    Write-Output $test.Tests
}


$stopTime = [DateTime]::Now
$timeSpend = ($stopTime -$startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timeSpend) seconds"