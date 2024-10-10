############################################################################################################
# Set these values
$containerName = 'BC'
$userName = 'admin'
$password = 'password'
$testSuite = 'DEFAULT'
$xunitResultsFile = "C:\ProgramData\BcContainerHelper\Extensions\$($containerName)\results.xml"
############################################################################################################

$scriptTitle = 'Run-TestsInBCContainer'

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($userName,$securePassword)

Run-TestsInBCContainer `
    -containerName $containerName `
    -credential $credential `
    -testSuite $testSuite `
    -detailed `
    -AppendToXUnitResultFile:($true) `
    -XUnitResultFileName $xunitResultsFile

$stopTime = [DateTime]::Now
$timeSpend = ($stopTime -$startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $timeSpend seconds"