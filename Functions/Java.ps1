$JAVA_PATH = "C:\Program Files\Java\"
function Set-JavaVersion([String] $version)
{
	$env:JAVA_HOME = [System.IO.Path]::Combine($JAVA_PATH,$version)
}

function Get-JavaVersions
{
	$currentVersion = Split-Path $env:JAVA_HOME -Leaf
	gci $JAVA_PATH | Select -ExpandProperty Name | %{
		if ($_ -eq $currentVersion)
		{
			return "* $_"
		}
		return $_
	}  
}