function gdp()
{
    function isPointingAtRoot($folder) { return $folder -eq "\" -or $folder -eq "/" }
    function isSpecialPathCharacter($folder) { return $folder.Contains(":") -or $folder.Contains("~") }

    # If called from command line, args will contain all folders
    $folders = $args
    # If called from another functions the space seperated folders are treated as one string
    if($args.count -eq 1){
        $folders = $args.Split(' ')
    }
    $pathsofar = ""
    foreach ($folder in $folders)
    {
        if(isPointingAtRoot($folder))
        {
            $drive = (Get-Location).Drive
            $pathsofar = [System.IO.Path]::Combine($pathsofar, $drive.Root)
            continue
        }
        if(isSpecialPathCharacter($folder))
        {
            if($folder.EndsWith(":"))
            {
                $folder += "\"
            }
            $pathsofar = [System.IO.Path]::Combine($pathsofar, $folder)
            continue
        }
        else
        {
            $found = gci -Path $pathsofar -Filter "$folder*" -Directory
            if($found.Count -gt 1)
            {
                $found | %{ Write-Host $_ -ForegroundColor Yellow }
                throw "'$folder' is ambigious."
            }
            else
            {
                if ($found.Count -eq 0)
                {
                    throw "Nothing found matching $folder in $pathsofar"
                }
                else
                {
                    $pathsofar = [System.IO.Path]::Combine($pathsofar, $found)
                    continue
                }
            }
        }
    }
    return $pathsofar
}
function ccd()
{
    $pth = gdp $args
    if($pth)
    {
        cd $pth
    }
}
function gfp()
{
    $filename = $args | Select -Last 1
    $directories = $args | Select -First ($args.count - 1)
    $pth = gdp $directories
    if($pth)
    {
        $matchedFiles = gci $pth -Filter "$filename*" -File
        if($matchedFiles.Count -gt 1)
        {
            $matchedFiles | %{ Write-Host $_ -ForegroundColor Yellow }
            throw "'$filename' is ambigious"
        }
        if($matchedFiles.Count -eq 0)
        {
            throw "File $filename not found in $fullpath"
        }
        $fullpath = [System.IO.Path]::Combine($pth, $matchedFiles[0])
        return $fullpath
    }
}