$JAVA_PATH = "C:\Program Files\Java\"
function Set-JavaVersion([String] $version)
{
	$env:JAVA_HOME = [System.IO.Path]::Combine($JAVA_PATH,$version)
}

function Get-JavaVersions
{
	gci $JAVA_PATH | Select Name
}