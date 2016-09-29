function Test-LoadedModule ($modulename)
{
    return (Get-Module -Name $modulename)
}

function Import-ConfigureModule()
{
    if (-not (Test-LoadedModule $moduleName))
    {
        Import-Module $moduleName -ErrorAction SilentlyContinue
    }
    if (Test-LoadedModule $moduleName)
    {
        configure
    }
    else
    {
        Write-Host "$moduleName not loaded"
        $installPrompt = Read-Host "Should $moduleName be installed? Y/n"
        if($installPrompt -ne "n")
        {
            Install-Module $moduleName -ErrorAction SilentlyContinue -Scope CurrentUser
            Import-Module $moduleName -ErrorAction SilentlyContinue
            configure
        }
    }
}
