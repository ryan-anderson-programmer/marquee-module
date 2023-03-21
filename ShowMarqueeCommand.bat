@ECHO OFF
REM    Copyright 2023 Ryan E. Anderson                                             
REM                                                                                
REM    Licensed under the Apache License, Version 2.0 (the "License");             
REM    you may not use this file except in compliance with the License.            
REM    You may obtain a copy of the License at                                     
REM                                                                                
REM        http://www.apache.org/licenses/LICENSE-2.0                              
REM                                                                                
REM    Unless required by applicable law or agreed to in writing, software         
REM    distributed under the License is distributed on an "AS IS" BASIS,           
REM    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    
REM    See the License for the specific language governing permissions and         
REM    limitations under the License.                                              
REM
REM    MarqueeModule v0.1.0 Show Marquee Command    
REM                                                 
REM    By Ryan E. Anderson                          
REM                                                 
REM    Copyright (C) 2023 Ryan E. Anderson          
SET current_directory=%~dp0
PowerShell.exe -Command "Import-Module %current_directory%marqueemodule/MarqueeModule.psm1; Get-Help Show-Marquee -Full; Show-Marquee -Title 'MarqueeModule v0.1.0' -Author 'Ryan E. Anderson' -Description 'This module displays information about a module or a script.' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -MaximumDescriptionLength 45"
PAUSE