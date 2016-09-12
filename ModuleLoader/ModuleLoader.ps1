function Test-LoadedModule ($modulename)
{
    return (Get-Module -ListAvailable -Name $modulename)
}

function Import-ConfigureModule()
{
    Import-Module $moduleName -ErrorAction SilentlyContinue
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
            Install-Module $moduleName
            Import-Module $moduleName -ErrorAction SilentlyContinue
            configure
        }
    }
}