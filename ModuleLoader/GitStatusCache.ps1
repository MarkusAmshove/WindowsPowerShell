$moduleName = 'GitStatusCachePoshClient'
Import-Module "$PROFILEPATH\ModuleLoader\git-status-cache-posh-client\GitStatusCachePoshClient.psm1"
function configure()
{
    $poshGitHasStatusCache = [bool]($GitPromptSettings.PSobject.Properties.name -match "EnableFileStatusFromCache")
    if($poshGitHasStatusCache)
    {
        $GitPromptSettings.EnableFileStatusFromCache = $true
    }
}
