[![Build status](https://ci.appveyor.com/api/projects/status/6g6mhjlm546066t1?svg=true)](https://ci.appveyor.com/project/mao/bingist)

# [binGist](https://github.com/turboBasic/binGist)


## ![0xHexagram][hexagram]

create Github gist with binary content #powershell #gist
> inspired by [PSGist]( https://github.com/dotps1/PSGist ) and other great pieces of software


## Installation

`Install-Module -Name binGist`


## Releases

History of releases and all downloads are available at [Powershell Gallery]( https://www.preview.powershellgallery.com/packages/binGist )


## Help

`Get-Help binGist`           <br>
`Get-Help binGist -full`     <br>
`Get-Help binGist -examples` <br>


## Usage

```
$ using module PSGist
$ New-BinaryGist -Path screenshot.png -Description 'Screenshot'
...
to https://gist.github.com/295602c25d587e637d5cc8279e449a5b.git
$ Get-Gist 295602c25d587e637d5cc8279e449a5b
```

[hexagram]: https://gist.githubusercontent.com/TurboBasic/9dfd228781a46c7b7076ec56bc40d5ab/raw/03942052ba28c4dc483efcd0ebf4bfc6809ed0d0/hexagram3D.png 'hexagram of Wisdom'
