[![Build status](https://ci.appveyor.com/api/projects/status/6g6mhjlm546066t1?svg=true)](https://ci.appveyor.com/project/mao/bingist)

# [binGist](https://github.com/turboBasic/binGist)


## ![0xHexagram][hexagram]

create Github gist with binary content #powershell #gist
> inspired by [PSGist]( https://github.com/dotps1/PSGist ) and other great pieces of software


## Installation

`Install-Module -Name binGist`


## Dependencies

1. [Git](https://git-scm.com/about)
2. [Github](https://github.com/about)
3. [Powershell/Powershell](https://github.com/PowerShell/PowerShell)
4. [PSGist](https://github.com/dotps1/PSGist)


## Releases

History of releases and all downloads are available at [Powershell Gallery]( https://www.preview.powershellgallery.com/packages/binGist )


## Help

`Get-Help binGist`           <br>
`Get-Help binGist -full`     <br>
`Get-Help binGist -examples` <br>


## Usage

```
$ New-BinaryGist -Path screenshot.png -Description 'Screenshot'
...
to https://gist.github.com/295602c25d587e637d5cc827eeeeffff.git
$ Get-Gist 295602c25d587e637d5cc827eeeeffff
Owner       : XXXXXXXXXX
Description : Screenshot
Id          : 295602c25d587e637d5cc827eeeeffff
CreatedAt   : 2018-07-27 21:54:52
UpdatedAt   : 2018-07-27 21:54:52
Public      : False
HtmlUrl     : https://gist.github.com/295602c25d587e637d5cc827eeeeffff
Files       : screenshot.png
```

[hexagram]: https://gist.githubusercontent.com/TurboBasic/9dfd228781a46c7b7076ec56bc40d5ab/raw/03942052ba28c4dc483efcd0ebf4bfc6809ed0d0/hexagram3D.png 'hexagram of Wisdom'
