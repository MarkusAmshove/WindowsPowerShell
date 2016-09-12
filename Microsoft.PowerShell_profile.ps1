$PROFILEPATH = Split-Path $PROFILE
$env:PSModulePath = $env:PSModulePath + ";$PROFILEPATH\ModuleLoader\Modules"
. "$PROFILEPATH\ModuleLoader\ModuleLoader.ps1"

# Load Modules
('PSreadline', 'PoshGit') | %{ . "$PROFILEPATH\ModuleLoader\$_.ps1"; Import-ConfigureModule }

# Load Functions
$functions = gci "$PROFILEPATH\Functions"
$functions | %{ . "$PROFILEPATH\Functions\$($_.Name)" }
clear