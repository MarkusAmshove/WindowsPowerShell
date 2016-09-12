$moduleName = 'GitStatusCachePoshClient'    
function configure()
{
    Import-Module "$PROFILEPATH\ModuleLoader\git-status-cache-posh-client\GitStatusCachePoshClient.psm1"
    $GitPromptSettings.EnableFileStatusFromCache = $true
}