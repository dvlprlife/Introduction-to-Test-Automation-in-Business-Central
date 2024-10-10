############################################################################################################
# Set these values
$baseFolder = "C:\Temp\Introduction-to-Test-Automation-in-Business-Central\"
$userName = 'admin'
$password = 'password'
$pipelineName = "DirectionsNA"
$appVersion = '25.0'
$affix = 'TIG'
$appFolders = "MainApp"
$testFolders = "TestApp"
$rulesetFile = Join-Path -Path $($baseFolder) -ChildPath $("Supporting-Files\untiltled.ruleset.json")
$outputFolder = "Pipeline"
$testResultsFile = "TestResults.xml"
$PackagesFolder = ".alpackages"
$outputFolder = "output"
$outputFolder = Join-Path -Path $baseFolder -ChildPath $outputFolder
$testResultsFile = Join-Path -Path $($baseFolder) -ChildPath $("TestResults.xml")

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($userName, $securePassword)

############################################################################################################


$scriptTitle = 'Run-AlPipeline'

$startTime = [DateTime]::Now
Write-Host -ForegroundColor Green "$($startTime) : $($scriptTitle) start"

Run-AlPipeline `
    -pipelineName $pipelineName `
    -baseFolder $baseFolder `
    -appFolders $appFolders `
    -testFolders $testFolders `
    -installTestFramework `
    -installTestLibraries `
    -enablePerTenantExtensionCop `
    -enableUICop `
    -enableCodeCop `
    -enableAppSourceCop `
    -appVersion $appVersion `
    -Credential $credential `
    -CreateRuntimePackages `
    -AppSourceCopMandatoryAffixes $affix `
    -AppSourceCopSupportedCountries "US" `
    -rulesetFile $rulesetFile `
    -outputFolder $outputFolder `
    -testResultsFile $testResultsFile `
    -packagesFolder $PackagesFolder


$stopTime = [DateTime]::Now
$timeSpend = ($stopTime -$startTime).TotalSeconds

Write-Host -ForegroundColor Green "$($stopTime) : $($scriptTitle) took $($timeSpend) seconds"