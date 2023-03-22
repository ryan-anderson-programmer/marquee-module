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

##############################################
#                                            #
#    MarqueeModule v0.1.0 Create Manifest    #
#                                            #
#    By Ryan E. Anderson                     #
#                                            #
#    Copyright (C) 2023 Ryan E. Anderson     #
#                                            #
##############################################

Write-Information -MessageData 'Determining whether PSScriptAnalyzer is installed...' -InformationAction Continue

if (Get-Module -ListAvailable -Name 'PSScriptAnalyzer') {
    Write-Information -MessageData 'PSScriptAnalyzer is installed.' -InformationAction Continue
} 
else {
    Write-Information -MessageData 'PSScriptAnalyzer is not installed.' -InformationAction Continue

    $response = Read-Host 'Press y to exit or any other key to continue'

    if ($response -ieq 'y') {
        exit
    }

    try {
        Write-Information -MessageData 'Determining whether NuGet is installed...' -InformationAction Continue

        if (Get-PackageProvider -ListAvailable -Name 'NuGet' -ErrorAction Stop) {
            Write-Information -MessageData 'NuGet is installed.' -InformationAction Continue
        }
    } 
    catch {
        Write-Warning $_.Exception

        Write-Information -MessageData 'NuGet is not installed.' -InformationAction Continue

        $response = Read-Host 'Press y to exit or any other key to continue'

        if ($response -ieq 'y') {
            exit
        }

        Write-Information -MessageData 'Installing NuGet...' -InformationAction Continue

        Install-PackageProvider -Name 'NuGet' -Force
    }

    Write-Information -MessageData ([String]::Format('{0}Installing PSScriptAnalyzer...', [Environment]::NewLine)) -InformationAction Continue

    Install-Module -Name 'PSScriptAnalyzer' -Force
}

Get-Command -Module PSScriptAnalyzer

$settings = @{
    Rules = @{
        PSUseCompatibleCommands = @{
            Enable         = $true
            TargetProfiles = @(
                'win-8_x64_10.0.14393.0_5.1.14393.2791_x64_4.0.30319.42000_framework' # Version 5.1 on Windows Server 2016
                'win-8_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework' # Version 5.1 on Windows Server 2019
                'win-48_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework' # Version 5.1 on Windows 10
            )
        }
        PSUseCompatibleSyntax   = @{
            Enable         = $true
            TargetVersions = @(
                '5.0'
            )
        }
    }
}

Invoke-ScriptAnalyzer -Path .\marqueemodule\MarqueeModule.psm1 -Settings $settings -Recurse -Severity Information 
Invoke-ScriptAnalyzer -Path .\marqueemodule\MarqueeModule.psm1 -Settings $settings -Recurse -Severity Warning
Invoke-ScriptAnalyzer -Path .\marqueemodule\MarqueeModule.psm1 -Settings $settings -Recurse -Severity Error

$parameters = @{
    Path              = (Join-Path $PSScriptRoot '..\marqueemodule\MarqueeModule.psd1')
    ModuleVersion     = '0.1.0'
    PowerShellVersion = '5.0'
    AliasesToExport   = @('sm')
    FunctionsToExport = @('Show-Marquee')
    RootModule        = 'MarqueeModule.psm1'
    Description       = 'This module contains a function that can be used to display information about a module or a script.'
    Author            = 'Ryan E. Anderson'
    Copyright         = 'Copyright (C) 2023 Ryan E. Anderson'
    Tags              = @('marquee', 'information', 'comments', 'box', 'command-line-interface', 'CLI', 'author', 'copyright', 'fine-print', 'title', 'description', 'shell', 'terminal', 'text', 'frame')
    LicenseUri        = 'https://github.com/ryan-anderson-programmer/marquee-module/blob/main/LICENSE'
    ProjectUri        = 'https://github.com/ryan-anderson-programmer/marquee-module'
    IconUri           = 'https://raw.githubusercontent.com/ryan-anderson-programmer/marquee-module/main/media/png/Marquee-Logo@1x.png'
    ReleaseNotes      = 'This is the initial release.'
    HelpInfoUri       = 'https://github.com/ryan-anderson-programmer/marquee-module/blob/main/README.md'
}

New-ModuleManifest @parameters 

Test-ModuleManifest .\marqueemodule\MarqueeModule.psd1

Read-Host 'Press any key to continue'