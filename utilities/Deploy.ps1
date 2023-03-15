#! /usr/bin/pwsh

##################################################################################
#                                                                                #
#    Copyright 2023 Ryan E. Anderson                                             #
#                                                                                #
#    Licensed under the Apache License, Version 2.0 (the "License");             #
#    you may not use this file except in compliance with the License.            #
#    You may obtain a copy of the License at                                     #
#                                                                                #
#        http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                                #
#    Unless required by applicable law or agreed to in writing, software         #
#    distributed under the License is distributed on an "AS IS" BASIS,           #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    #
#    See the License for the specific language governing permissions and         #
#    limitations under the License.                                              #
#                                                                                #
##################################################################################

#############################################
#                                           #                      
#    MarqueeModule v0.1.0 Deploy Script     #
#                                           #
#    By Ryan E. Anderson                    #
#                                           #
#    Copyright (C) 2023 Ryan E. Anderson    #
#                                           #
#############################################

<#
    .SYNOPSIS
    This script will build and import MarqueeModule for development and testing as well as prepare an environment for a deployment.

    .DESCRIPTION
    This script will build and import MarqueeModule for development and testing as well as prepare an environment for a deployment. Files from a previous build may be removed by the use of a switch.

    .PARAMETER Clean
    This is a switch that can be used to ensure that the output from a previous build is cleaned.
    
    .PARAMETER Test
    This is a switch that can be used to specify whether testing should be performed.
#>
[CmdletBinding()]
param(
    [switch]$Clean,
    [switch]$Test
)

Set-StrictMode -Version Latest

if (!(Get-PackageProvider | Where-Object { $_.Name -eq 'NuGet' })) {
    Install-PackageProvider -Name 'NuGet' -Force | Out-Null
}

Import-PackageProvider -Name 'NuGet' -Force | Out-Null

if ((Get-PSRepository -Name 'PSGallery').InstallationPolicy -ne 'Trusted') {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy 'Trusted'
}

. (Join-Path -Path $PSScriptRoot -ChildPath '.\Build.ps1' -ErrorAction Stop) -Clean:$Clean -Test:$Test