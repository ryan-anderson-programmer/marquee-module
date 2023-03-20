@ECHO OFF
SET current_directory=%~dp0
PowerShell.exe -Command "Import-Module %current_directory%marqueemodule/MarqueeModule.psm1; Get-Help Show-Marquee -Full; Show-Marquee -Title 'MarqueeModule v0.1.0' -Author 'Ryan E. Anderson' -Description 'This module displays information about a module or a script.' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -MaximumDescriptionLength 45"
PAUSE