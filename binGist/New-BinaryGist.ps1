function New-BinaryGist {
<#
    .SYNOPSIS
Creates binary gists on GitHub. 

    .DESCRIPTION
Creates binary gists on GitHub.  Standard API doesn't allow this forcing users to 
cumbersome manual operations, eg. https://gist.github.com/remarkablemark/feff40b0a522f0c41c4eff0b77ea1d47

    .EXAMPLE
New-BinaryGist -path pirate_map.png -description 'Secret Map'

#> 

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    Param(
      [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
      [ValidateScript({
          foreach ($item in $_) {
              try   { Test-Path $item -pathType Leaf -errorAction Stop }
              catch { throw "[$($MyInvocation.MyCommand)] $item do not exist or is directory. Only files are allowed in gists" }
          }
          $True
      })]
      [string[]]  $Path,
      
      [Parameter(Position=1)]
      [string]    $Description = "binGist: pirate's secret map",
      
      [switch]    $Force
    )
    
  BEGIN {    
    if (-not $psBoundParameters.ContainsKey('Verbose')) {
      $VerbosePreference = $psCmdlet.SessionState.psVariable.GetValue('VerbosePreference')
    }
    if (-not $psBoundParameters.ContainsKey('Confirm')) {
      $ConfirmPreference = $psCmdlet.SessionState.psVariable.GetValue('ConfirmPreference')
      $PSBoundParameters.Confirm = $false
    }
    if (-not $psBoundParameters.ContainsKey('WhatIf')) {
      $WhatIfPreference =  $psCmdlet.SessionState.psVariable.GetValue('WhatIfPreference')
    }
    $psBoundParameters.Remove('Force') | Out-Null 
    $psBoundParameters.Remove('Path') | Out-Null
    $psBoundParameters.Remove('Description') | Out-Null
    
    Write-Verbose ('[{0}] Confirm={1} ConfirmPreference={2} WhatIf={3} WhatIfPreference={4}' -f 
        $MyInvocation.MyCommand, $Confirm, $ConfirmPreference, $WhatIf, $WhatIfPreference
    )
    
    # Text placeholder to start something with
    $placeholder = [IO.Path]::GetTempFileName()
    Write-Verbose "[$($MyInvocation.MyCommand)] Create temp placeholder $placeholder"
    try {
      $placeholder = [IO.Path]::GetTempFileName()
      Rename-Item -path $placeholder -newName "$placeholder.txt" @psBoundParameters
      $placeholder += '.txt'
      Add-Content -path $placeholder -value 'binGist: this will die in a moment' @psBoundParameters
    }
    catch {
      Write-Error "[$($MyInvocation.MyCommand)] Cannot create placeholder file"
    }
  }
  
  PROCESS {
    if (-not $Force -and 
        -not $psCmdlet.ShouldProcess($Path -join ', ', "Create a gist based on set of files")
    ) {
      return
    }
   
    # Create a gist with placeholder file with a text content as required by Github API
    try {
      $gist = New-Gist -path $placeholder -description $Description
    } catch {
      Write-Error "[$($MyInvocation.MyCommand)] Cannot create gist"
    } finally {
      Remove-Item $placeholder -force 
    }
    
    # Fetch created gist from Github and remove placeholder 
    git clone $gist.htmlUrl
    Set-Location $gist.id
    Remove-Item -path [IO.Path]::GetFileName($placeholder) @psBoundParameters
      
    # Bring 'real' stuff to gist
    foreach ($1path in $Path) 
    {        
      if (Test-Path $1path -pathType Leaf) {
        Copy-Item -path $1path -destination . @psBoundParameters       
      } else {
        Write-Warning "[$($MyInvocation.MyCommand)] Skip $1path from copying to gist: item does not exist or is a directory"
      }
    }
      
    # Commit the changes and push gist
    git add . > $Null
    git commit -m "binGist: pirate's map replaced with payload"
    Write-Verbose "[$($MyInvocation.MyCommand)] Git successfully committed the update gist"
    
    try     { git push }
    catch   { "[$($MyInvocation.MyCommand)] Git cannot push repo to Github. Check local repo at ./$(Get-Location)" }
    finally { Set-Location .. }
    
    # Get updated gist and return it to the user
    Get-Gist -id $gist.id      
  }
  
  END {}
  
}
