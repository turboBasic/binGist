@{
    # Some defaults for all dependencies
    PSDependOptions = @{
        Parameters = @{
            Force = $true
        }
    }

    # Grab some modules without depending on PowerShellGet
    'Psake' = @{ DependencyType = 'PSGalleryModule' }
    'PSDeploy' = @{ DependencyType = 'PSGalleryModule' }
	'PSScriptAnalyzer' = @{ DependencyType = 'PSGalleryModule' }
    'BuildHelpers' = @{ DependencyType = 'PSGalleryModule' }
    'Pester' = @{
        DependencyType = 'PSGalleryModule'
        Version = '3.4.0'
        SkipPublisherCheck = $true
    }
}
