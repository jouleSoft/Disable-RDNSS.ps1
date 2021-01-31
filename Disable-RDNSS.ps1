#Requires -Version 5
#Requires -PSEdition Desktop
#Requires -Modules NetAdapter
#Requires -RunAsAdministrator

<#
.SYNOPSIS
  Disabling ICMPv6 RDNSS from all availiable network interfaces

.DESCRIPTION
  Disabling ICMPv6 RDNSS from all availiable network interfaces to solve the published vulnerability in Bad Neighbor by Centro Criptológico Nacional (CCN) on Microsoft Windows 10, Microsoft Windows Server 2016, Microsoft Windows Server 2012-R2, Microsoft Windows Server 2012.

.INPUTS
  None

.OUTPUTS
  None

.NOTES
  GitHub repo:      https://github.com/jouleSoft/Disable-RDNSS.ps1
  License:          The MIT License (MIT)
                    Copyright (c) 2020 Julio Jiménez Delgado (jouleSoft)
  PS Edition:       Desktop
  Template:         https://gist.github.com/jouleSoft/b10ede4ff3ef47122f9041a3f205c245
  --
  Version:          1.0
  Author:           Julio Jimenez Delgado (jouleSoft)
  Creation Date:    25/11/2020
  Purpose/Change:   Initial script development

.EXAMPLE
  ICMPv6 Recursive DNS Server (RDNSS) will be disable from all network interfaces

  PS> Disable-IPv6W10.ps1


.EXAMPLE
  If TotalDisable parameter is activated, IPv6 stack will be also disable from all interfaces

  Disable-IPv6W10.ps1 -TotalDisable

.LINK
  https://www.ccn-cert.cni.es/seguridad-al-dia/avisos-ccn-cert/10594-ccn-cert-av-72-20-vulnerabilidad-en-bad-neighbor.html
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Script parameters
Param(
    [Parameter(Mandatory=$False)]
    [Switch]$TotalDisable
)

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptName         = "Disable-RDNSS.ps1"
$sScriptVersion      = "1.0"
$sScriptDescription  = "Disabling ICMPv6 RDNSS in all availiable network interfaces"
$sScriptLicense      = "MIT"

#-----------------------------------------------------------[Functions]------------------------------------------------------------

<#
Function <FunctionName>{
  Param()

  Begin{
    Log-Write -LogPath $sLogFile -LineValue "<description of what is going on>..."
  }

  Process{
    Try{
      <code goes here>
    }

    Catch{
      Log-Error -LogPath $sLogFile -ErrorDesc $_.Exception -ExitGracefully $True
      Break
    }
  }

  End{
    If($?){
      Log-Write -LogPath $sLogFile -LineValue "Completed Successfully."
      Log-Write -LogPath $sLogFile -LineValue " "
    }
  }
}
#>

function Get-ScriptHeader {
    <#
    .SYNOPSIS
      Print header lines

    .DESCRIPTION
      For script use. Print the first script lines indicating title, version, description and license.

    .PARAMETER Title
      Mandatory. Script title.

    .PARAMETER Version
      Mandatory. Script version

    .PARAMETER Description
      Mandatory. Script description

    .PARAMETER Version
      Mandatory. Script license. Set to $Null for no license.

    .INPUTS
      Paramaters above

    .OUTPUTS
      String

    .NOTES
      Version:          1.0
      Author:           Julio Jimenez Delgado (jouleSoft)
      Creation Date:    14/05/2020
      Change:           Written
    #>

    [CmdletBinding()]

    Param(
        [Parameter(Mandatory=$True, Position=0)]
        [String]$Title,
        [Parameter(Mandatory=$True, Position=1)]
        [String]$Version,
        [Parameter(Mandatory=$True, Position=2)]
        [String]$Description,
        [Parameter(Mandatory=$False, Position=3)]
        [String]$License
    )

    Process{
        Write-Host "$Title v."			-ForegroundColor Gray	-noNewLine
        Write-Host $Version					-ForegroundColor Yellow	-noNewLine
        Write-Host " - $Description" 	-ForegroundColor Gray -NoNewline

        if($License -ne $Null){
            Write-Host " ($License)" -ForegroundColor Gray
        }
    }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Show script header
Get-ScriptHeader -Title $sScriptTitle -Version $sScriptVersion -Description $sScriptDescription -License $sScriptLicense

# Disabling ICMPv6 Recursive DNS Server (RDNSS) from all network interfaces
Get-NetIPInterface -AddressFamily ipv6 | Foreach-Object {
    $rfc = (& netsh int ipv6 show int $_.ifIndex) -match '(RFC 6106)'
    if($rfc -like "*enabled"){
        netsh int ipv6 set int $_.ifIndex rabaseddnsconfig=disable
    }
}

# If TotalDisable parameter is activated, disabling also IPv6 stack from all interfaces
if ($TotalDisable){
    $(Get-NetAdapterBinding -ComponentID ms_tcpip6).Name | Foreach-Object {
        disable-NetAdapterBinding -InterfaceAlias "$_" -ComponentID ms_tcpip6
    }
}

## Unloading variables and constants ##
remove-variable -Name sScriptName
remove-variable -Name sScriptVersion
remove-variable -Name sScriptDescription
remove-variable -Name sScriptLicense
