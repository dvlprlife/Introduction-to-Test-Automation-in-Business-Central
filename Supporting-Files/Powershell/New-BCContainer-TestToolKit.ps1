############################################################################################################

$containerName = 'BC22-Test'
$userName = 'admin'
$password = 'password'
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($userName,$securePassword)

############################################################################################################

$scriptTitle = 'New-BCContainer'

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

$artifactUrl = Get-BCArtifactUrl -version 22 -country "us" -select Latest -type Sandbox
Write-Host -ForegroundColor Yellow ($artifactUrl)

New-BCContainer  `
    -accept_eula `
    -accept_outdated `
    -alwaysPull `
    -artifactUrl $artifactUrl `
    -auth NavUserPassword `
    -containerName $containerName `
    -Credential $credential `
    -includeTestToolkit `
    -isolation hyperv `
    -updateHosts `

$stopTime = [DateTime]::Now
$timeSpend = ($stopTime -$startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timespend) seconds"



