function New-BinaryGist 
{ 	<#

    .SYNOPSIS
Creates binary gists on GitHub (which is a bit non-trivial).

    .DESCRIPTION
Creates binary gists on GitHub.  Standard API doesn't allow this forcing users to
cumbersome manual operations, eg. https://gist.github.com/remarkablemark/feff40b0a522f0c41c4eff0b77ea1d47

    .PARAMETER Path
Path to content to place in gist. Can be text, image, binary blob, whatever.

    .PARAMETER Description
Description of content.

    .NOTES
Copyright 2018 Andriy Melnyk (mao@bebee.xyz), all rights reserved    

    .EXAMPLE
New-BinaryGist -path 卐screenshot卍.png -description 'Screenshot'

    .LINK
https://raw.githubusercontent.com/turboBasic/binGist/master/HelpFile.md    

#>


	[CmdletBinding(
		ConfirmImpact = 'Low',
		SupportsShouldProcess,
		HelpURI = ''
	)]
	Param(
		[Parameter(Mandatory, Position=0)] 
		[ValidateNotNullOrEmpty()]
		[String] $Path,
		
		[Parameter(Position=1)]
		[String] $Description = "Binary gist created by binGist"
	)

	BEGIN 
    {
        Set-StrictMode -Version Latest

		$saved = $ErrorActionPreference
		$ErrorActionPreference = 'Stop'
		
		if (-not $psBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $psCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $psBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $psCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
        if (-not $psBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $psCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
	}
		
	
	PROCESS
	{
        if ($psCmdlet.ShouldProcess((Resolve-Path $Path), "Create Github gist with binary payload")) {
            $ConfirmPreference = 'None'

			$t = New-TemporaryFile
			'dummy' | Add-Content $t
			
			Write-Verbose "Create initial gist with text-only payload"
			$binaryGist = $t | New-Gist -Description 'our binary gist' 
			Remove-Item -Path $t			
			
			
			Write-Verbose "Add our binary payload to the gist and delete initial text content"
			git clone https://gist.github.com/$($binaryGist.Id).git
			Copy-Item -Path $Path -Destination $binaryGist.Id
			
			
			Push-Location -Path $binaryGist.Id
				Remove-Item -Path $t.Name			
				git add -A  | Out-Null
				git commit -m "Add binary payload" | Out-Null
				
				Write-Verbose "Save final gist on Github"
				git push	| Out-Null
			Pop-Location
			
			Write-Verbose "Remove local gist"
			Remove-Item -Path $binaryGist.Id -force
        }
	}
	
	
	END 
	{	
		$ErrorActionPreference = $saved
		return

		trap {
			"Error in function $($MyInvocation.MyCommand): $_"
			$ErrorActionPreference = $saved	
			if(Test-Path -Path $t) {
				Remove-Item $t
			}
		}	
	}
}
 