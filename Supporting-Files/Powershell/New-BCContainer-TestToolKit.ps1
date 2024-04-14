############################################################################################################
# Set these values
$containerName = 'BC24'
$version = 24
$scriptTitle = 'New-BCContainer'
$UserName = 'admin'
$Password = 'password'
############################################################################################################

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName,$SecurePassword)

$artifactUrl = Get-BCArtifactUrl -version @version -country "us" -select Latest -type Sandbox
Write-Host -ForegroundColor Yellow ($artifactUrl)

New-BCContainer  `
    -accept_eula `
    -accept_outdated `
    -alwaysPull `
    -artifactUrl $artifactUrl `
    -auth NavUserPassword `
    -containerName $containerName `
    -Credential $Credential `
    -includeTestToolkit `
    -isolation hyperv `
    -updateHosts `
    -memoryLimit 8G


$stopTime = [DateTime]::Now
$timeSpend = ($stopTime - $startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timespend) seconds"


