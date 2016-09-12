$moduleName = 'posh-git'
function configure()
{
    $GitPromptSettings.EnableStashStatus = $true
    Start-SshAgent -Quiet
    function Global:prompt 
    {
        $realLASTEXITCODE = $LASTEXITCODE

        Write-Host

        # Reset color, which can be messed up by Enable-GitColors
        $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

        function Test-Administrator {
            $user = [Security.Principal.WindowsIdentity]::GetCurrent();
            (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
        }

        if (Test-Administrator) {  # Use different username if elevated
            Write-Host "(Elevated) " -NoNewline -ForegroundColor White
        }

        Write-Host "$ENV:USERNAME@" -NoNewline -ForegroundColor DarkYellow
        Write-Host "$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Magenta

        if ($s -ne $null) {  # color for PSSessions
            Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
            Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
            Write-Host ") " -NoNewline -ForegroundColor DarkGray
        }

        Write-Host " : " -NoNewline -ForegroundColor DarkGray
        Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Blue
        Write-Host " : " -NoNewline -ForegroundColor DarkGray
        Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
        Write-Host " : " -NoNewline -ForegroundColor DarkGray

        $global:LASTEXITCODE = $realLASTEXITCODE

        Write-VcsStatus

        Write-Host ""

        return "> "
    }

}