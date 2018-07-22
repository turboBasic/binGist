#Requires -Version 5
#Requires -Modules PSGist

# get public and private function definition files
$public = @( Get-ChildItem -path $PSScriptRoot\public -filter *.ps1 -file -recurse -errorAction SilentlyContinue )
$private = @( Get-ChildItem -path $PSScriptRoot\private -filter *.ps1 -file -recurse -errorAction SilentlyContinue )
$moduleRoot = $psScriptRoot
$moduleName = Split-Path -path $psScriptRoot -leaf


# dot source the files
foreach ( $import in @( $public + $private ) )
{
    try   { . $import.fullname }
    catch { Write-Error -message "$moduleName :: Failed to import function $( $import.fullname ): $_"  }
}


Export-ModuleMember -function $public.Basename
