<!-- start project-info -->
<!--
github_project: https://github.com/jouleSoft/Disable-RDNSS.ps1
license: MIT
license-badge: True
contributors-badge: True
lastcommit-badge: True
codefactor-badge: True
--->
<!-- end project-info -->

<!-- start badges -->
![License MIT](https://img.shields.io/badge/license-MIT-green)
![Contributors](https://img.shields.io/github/contributors-anon/jouleSoft/Disable-RDNSS.ps1)
![Last commit](https://img.shields.io/github/last-commit/jouleSoft/Disable-RDNSS.ps1)
<!-- end badges -->

<!-- start description -->
<h1 align="center"><span id="project_title">Disable-RDNSS.ps1</span></h1>
<p><span id="project_title">Disable-RDNSS.ps1</span> is a PowerShell script which disables ICMPv6 RDNSS from all availiable network interfaces. This solves the published vulnerability in Bad Neighbor by Centro Criptológico Nacional (CCN) on Microsoft Windows 10, Microsoft Windows Server 2016, Microsoft Windows Server 2012-R2, Microsoft Windows Server 2012.</p>
<!-- end description -->

<!-- start prerequisites -->
## Prerequisites
* Windows PowerShell **5.0+** (Desktop edition)
* NetAdapter module 
* Administrator privileges
<!-- end prerequisites -->

<!-- start examples -->
## Examples
### Disabling ICMPv6 RDNSS from all availiable network interfaces

``` 
PS > Disable-RNDSS.ps1 
```

### Disable TCP/IPv6 stack

``` 
PS > Disable-RNDSS.ps1 -TotalDisable
```
<!-- end examples -->
