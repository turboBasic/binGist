#Requires -Version 5.0


# PSDepend:     0.1.62
# Invoke-Build: 5.0.0

'PSDepend', 'InvokeBuild' |
ForEach-Object {
    if (-not(Get-Module -name $_ -listAvailable)) {
        try   {
            Install-Module -name $_ -repository psGallery -scope CurrentUser -verbose
        }
        catch { Write-Error "Cannot install $_!" }
    }
}

Invoke-Build -verbose
