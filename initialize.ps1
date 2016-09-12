$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
git submodule update --init --recursive
& "$scriptPath\ModuleLoader\git-status-cache-posh-client\install.ps1"