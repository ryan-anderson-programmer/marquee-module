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
#    MarqueeModule v0.1.0 Unit Test Suite    #
#                                            #
#    By Ryan E. Anderson                     #
#                                            #
#    Copyright (C) 2023 Ryan E. Anderson     #
#                                            #
##############################################

InModuleScope 'MarqueeModule' {
    Describe 'Get-MarqueeEmptyRow' {
        It 'Should have a parameter named Format' {
            Get-Command 'Get-MarqueeEmptyRow' | Should -HaveParameter 'Format' -Type 'string' -Mandatory
        }
    }

    Describe 'Get-MarqueeContentRow' {
        BeforeAll {
            function Get-CommandUnderTest {
                Get-Command 'Get-MarqueeContentRow'
            }
        }

        It 'Should have a parameter named Content' {
            Get-CommandUnderTest | Should -HaveParameter 'Content' -Type 'string' -Mandatory
        }

        It 'Should have a parameter named ContentLength' {
            Get-CommandUnderTest | Should -HaveParameter 'ContentLength' -Type 'int' -Mandatory
        }

        It 'Should have a parameter named MaximumLength' {
            Get-CommandUnderTest | Should -HaveParameter 'MaximumLength' -Type 'int' -Mandatory
        }
    }

    Describe 'Show-Marquee' {
        Context 'When default parameters are used' {
            Mock Write-Information { }

            $null = Show-Marquee -Title 'Marquee Module v0.1.0' -Author 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson'

            It 'Calls Write-Information 9 times to print information about a module or script' {
                Assert-MockCalled Write-Information -Exactly 9
            }
        }

        Context 'When description parameters are used and the maximum length of a provided description is less than its actual length' {
            Mock Write-Information { }

            $null = Show-Marquee -Title 'Marquee Module v0.1.0' -Author 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -Description 'This is a command for displaying information about a module or script. A title, authors, and fine print are displayed within a box when this command is invoked.' -MaximumDescriptionLength 50

            It 'Calls Write-Information 14 times to print information about a module or script' {
                Assert-MockCalled Write-Information -Exactly 14
            }
        }

        Context 'When an argument for a description is provided, an argument for the maximum length of that description is not provided, and the actual length of that description is greater than the maximum length' {
            Mock Write-Information { }

            $null = Show-Marquee -Title 'Marquee Module v0.1.0' -Author 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -Description 'This is a command for displaying information about a module or script. A title, authors, and fine print are displayed within a box when this command is invoked.'

            It 'Calls Write-Information 12 times to print information about a module or script' {
                Assert-MockCalled Write-Information -Exactly 12
            }
        }

        Context 'When an argument for a description is provided and its actual length is equal to the maximum length' {
            Mock Write-Information { }

            $null = Show-Marquee -Title 'Marquee Module v0.1.0' -Author 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -Description 'This is a command for displaying information about a module or script. A title, authors, and fine print are displayed within a box when this command is invoked.' -MaximumDescriptionLength 160

            It 'Calls Write-Information 11 times to print information about a module or script' {
                Assert-MockCalled Write-Information -Exactly 11
            }
        }
    }
}