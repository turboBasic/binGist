#Requires -Version 5.0

if (-not(Get-Module -name InvokeBuild -ListAvailable)) {
    try   {
        Install-Module -name InvokeBuild -verbose
    }
    catch { Write-Error "Cannot install InvokeBuild!" }
}

Import-Module -name InvokeBuild -force
Invoke-Build -path ($psScriptRoot)