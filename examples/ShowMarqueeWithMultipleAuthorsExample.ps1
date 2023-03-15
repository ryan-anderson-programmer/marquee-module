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

#########################################################################
#                                                                       #
#    MarqueeModule v0.1.0 Show Marquee With Multiple Authors Example    #
#                                                                       #
#    By Ryan E. Anderson                                                #
#                                                                       #
#    Copyright (C) 2023 Ryan E. Anderson                                #
#                                                                       #
#########################################################################

Set-StrictMode -Version Latest

Import-Module MarqueeModule

$null = Show-Marquee -Title 'Marquee Module v0.1.0' -Author 'John Doe', 'Jane Doe', 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 John and Jane Doe'

Read-Host 'Press any key to continue'