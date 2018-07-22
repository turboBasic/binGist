@{
    RootModule = 'binGist.psm1'
    Author = 'Andriy Melnyk <mao@bebee.xyz>'
    CompanyName = 'Cargonautica'
    ModuleVersion = '0.1'
    GUID = '79e010c5-4c3d-4875-917a-172243336e28'
    Copyright = '2018 Andriy Melnyk'
    Description = "create Github gist with binary content #powershell #gists"
    PowerShellVersion = '5.1.0.0'
    CompatiblePSEditions = @('Desktop', 'Core')
	RequiredModules = @( @{ ModuleName = 'PSGist'; ModuleVersion = '2.0' } )
    FunctionsToExport = '*'
    AliasesToExport = @('')
    VariablesToExport = @('')
    PrivateData = @{
        PSData = @{
            Tags = @('tools', 'GitHub', 'gist')
            LicenseUri = 'https://choosealicense.com/licenses/mit'
            ProjectUri = 'https://github.com/turboBasic/binGist'
            IconUri = 'https://gist.githubusercontent.com/turboBasic/9dfd228781a46c7b7076ec56bc40d5ab/raw/03942052ba28c4dc483efcd0ebf4bfc6809ed0d0/hexagram3D.png'
            ReleaseNotes = @'
'@
        }
    }
    HelpInfoURI = 'https://raw.githubusercontent.com/turboBasic/binGist/master/HelpFile.md'
}
