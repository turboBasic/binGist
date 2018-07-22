# Help file for New-BinGist cmdlet


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
