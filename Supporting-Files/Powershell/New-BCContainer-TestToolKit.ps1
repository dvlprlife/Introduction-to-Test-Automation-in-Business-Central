  ############################################################################################################
# Set these values

$containerName = 'BC'
$version = 25
$UserName = 'admin'
$Password = 'password'
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName,$SecurePassword)

############################################################################################################

$scriptTitle = 'New-BCContainer'
$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

$artifactUrl = Get-BCArtifactUrl -version $version -country "us" -select Latest -type Sandbox
Write-Host -ForegroundColor Yellow ($artifactUrl)

New-BCContainer  `
    -accept_eula `
    -accept_outdated `
    -accept_insiderEula $true  `
    -alwaysPull `
    -artifactUrl $artifactUrl `
    -auth NavUserPassword `
    -containerName $containerName `
    -Credential $Credential `
    -isolation hyperv `
    -includeTestToolkit `
    -memoryLimit 8G `
    -updateHosts

$stopTime = [DateTime]::Now
$timeSpend = ($stopTime - $startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timespend) seconds" 
