Using Module PSGist
$projectRoot = Resolve-Path $PSScriptRoot\..
$moduleRoot = Split-Path (Resolve-Path $projectRoot\*\*.psm1)
$moduleName = Split-Path $moduleRoot -Leaf
$projectRoot, $moduleRoot, $moduleName | Write-Host



Describe "General project validation: $moduleName" {

    $scripts = Get-ChildItem $projectRoot -Include *.ps1,*.psm1,*.psd1 -Recurse

    # TestCases are splatted to the script so we need hashtables
    $testCase = $scripts | Foreach-Object { @{ file = $_}  }

    It "Script <file> should be valid powershell" -TestCases $testCase {
        Param( $file )

        $file.FullName | Should Exist

        $contents = Get-Content -Path $file.FullName -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize( $contents, [ref] $errors )
        $errors.Count | Should Be 0
    }

    It "Module '$moduleName' can import cleanly" {
        {Import-Module (Join-Path $moduleRoot "$moduleName.psm1") -force } | Should Not Throw
    }
}



<#
Describe "Validate New-BinaryGist" { 
    Context "Invoke-ScriptAnalyzer -Path $(Resolve-Path -Path (Get-Location))\Public\New-BinaryGist.ps1." {
        $results = Invoke-ScriptAnalyzer -Path .\binGist\Public\New-BinaryGist.ps1

        It "Invoke-ScriptAnalyzer results of New-BinaryGist should be 0." {
            $results.Count | Should Be 0
        }
    }
}
#>