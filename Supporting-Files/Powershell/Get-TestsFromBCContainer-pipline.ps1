############################################################################################################
$containerName = 'BC'
$userName = 'admin'
$password = 'password'
$testSuite = 'DEFAULT'
$xunitResultsFile = "C:\ProgramData\BcContainerHelper\Extensions\$($containerName)\results.xml"
############################################################################################################

$scriptTitle = 'Get-TestsFromBCContainer Pipeline'

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($userName,$securePassword)

$first = $true
$tests = Get-TestsFromBCContainer `
    -containerName $containerName `
    -Credential $Credential `
    -testSuite $testSuite `
    -ignoreGroups

$tests | ForEach-Object {
    Run-TestsInBCContainer `
        -containerName $containerName `
        -credential $credential `
        -XUnitResultFileName $xunitResultsFile `
        -AppendToXUnitResultFile:(!$first) `
        -testCodeunit $_.Id
    $first = $false
}

$stopTime = [DateTime]::Now
$timeSpend = ($stopTime -$startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timeSpend) seconds"