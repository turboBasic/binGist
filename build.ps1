#Requires -Version 5.0

$whatIf = $True


'PSDepend', 'InvokeBuild' |
ForEach-Object {
    if (-not(Get-Module -name $_ -listAvailable)) {
        try   {
            Install-Module -name $_ -repository psGallery -scope CurrentUser -verbose
        }
        catch { Write-Error "Cannot install $_!" }
    }
}

$myModule = Split-Path -path $psScriptRoot -leaf
Write-Host "myModule: $myModule"
$buildScript = Join-Path -path $psScriptRoot -childPath "$myModule.build.ps1"
Write-Host "buildScript: $buildScript"
#Invoke-Build -file $buildScript -verbose
Invoke-Build -verbose
