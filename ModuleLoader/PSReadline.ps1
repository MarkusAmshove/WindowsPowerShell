$moduleName = 'PSReadline'
function configure()
{
    Set-PSReadlineOption -EditMode Emacs
    Set-PSReadlineKeyHandler -Key CTRL+V -Function Paste
    Set-PSReadlineOption -TokenKind Command -ForegroundColor Red
}