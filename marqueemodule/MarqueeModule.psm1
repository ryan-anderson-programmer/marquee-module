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
#    MarqueeModule v0.1.0                   #
#                                           #
#    By Ryan E. Anderson                    #
#                                           #
#    Copyright (C) 2023 Ryan E. Anderson    #
#                                           #
#############################################

Set-StrictMode -Version Latest

function Get-MarqueeEmptyRow {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $Format
    )
    [string]::Format($Format, '#', '#')
}

function Get-MarqueeContentRow {
    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $Content,
        [Parameter(Mandatory)]
        [int]
        $ContentLength,
        [Parameter(Mandatory)]
        [int]
        $MaximumLength
    )
    [string]::Format('{0,-5}{1}{2,' + ($MaximumLength - $ContentLength + 5) + '}', '#', $Content, '#')
}

<#
    .SYNOPSIS
    This function displays a box that contains information about a project.

    .DESCRIPTION
    This function displays a box containing a title, the names of authors, and fine print, such as copyright information, for a project. It can also display a description of a project.

    .PARAMETER Title
    This is the title of a project.

    .PARAMETER Description
    This is the description of a project.

    .PARAMETER Author
    This is a comma-separated list of authors that contributed to a project.

    .PARAMETER FinePrint
    This is fine print for a project. Copyright information or other information related to terms and conditions can be assigned to this parameter.

    .PARAMETER MaximumDescriptionLength
    This is the maximum length of a description. This value overrides the actual length of a description. The default value for the maximum length of a description is 128.

    .EXAMPLE
    # Create a marquee that contains one author.
    Show-Marquee -Title 'Project' -Author 'John Doe' -FinePrint 'Copyright (C) 2023 John Doe'

    .EXAMPLE
    # Create a marquee that contains multiple authors.
    Show-Marquee -Title 'Project' -Author 'John Doe', 'Jane Doe' -FinePrint 'Copyright (C) 2023 John and Jane Doe'

    .EXAMPLE
    # Create a marquee that contains a description.
    Show-Marquee -Title 'Marquee Module v0.1.0' -Author 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -Description 'This is a command for displaying information about a module or a script. A title, authors, and fine print are displayed within a box when this command is invoked.' -MaximumDescriptionLength 50

    .NOTES
    All provided information is literal and will not be trimmed. Words within the description will not wrap; they will be broken at the maximum length.
#>
function Show-Marquee {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param(
        [Parameter(Position = 0, Mandatory, ParameterSetName = 'Default')]
        [string]
        $Title,
        [Parameter(Position = 1, Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Position = 0, Mandatory, ParameterSetName = 'Description')]
        [string]
        $Description,
        [Parameter(Position = 2, Mandatory, ParameterSetName = 'Default')]
        [string[]]
        $Author,
        [Parameter(Position = 3, Mandatory, ParameterSetName = 'Default')]
        [string]
        $FinePrint,
        [Parameter(Position = 4, Mandatory = $false, ParameterSetName = 'Default')]
        [Parameter(Position = 1, Mandatory = $false, ParameterSetName = 'Description')]
        [ValidateRange(0, 256)]
        [int]
        $MaximumDescriptionLength = 128
    )

    if ($Author.Length -eq 2) {
        $authorCsv = [string]::Format('{0} and {1}', $Author[0], $Author[1])
    }
    else {
        $authorCsv = $Author -join ', '
    }

    $titleLength = $Title.Length
    $authorLength = $authorCsv.Length + 3 # length of CSV list of authors + length of 'By '
    $finePrintLength = $FinePrint.Length
    $descriptionLength = $Description.Length

    $lengthsDescription = @($descriptionLength, $MaximumDescriptionLength)

    $minimumLengthDescription = ($lengthsDescription | Measure-Object -Minimum).Minimum

    $lengths = @($titleLength, $authorLength, $finePrintLength, $minimumLengthDescription)

    $maximumLength = ($lengths | Measure-Object -Maximum).Maximum

    $horizontalBorderLength = $maximumLength + 10 # m spaces on either side times n sides = 5 * 2 = 10

    $horizontalBorder = '#' * $horizontalBorderLength

    $verticalBorderPosition = $horizontalBorderLength - 1

    $emptyRowFormat = '{0}{1,' + $verticalBorderPosition + '}'

    $authorByline = [string]::Format('By {0}', $authorCsv)

    Write-Information -MessageData $horizontalBorder -InformationAction Continue
    Write-Information -MessageData (Get-MarqueeEmptyRow -Format $emptyRowFormat) -InformationAction Continue
    Write-Information -MessageData (Get-MarqueeContentRow -Content $Title -ContentLength $titleLength -MaximumLength $maximumLength) -InformationAction Continue
    Write-Information -MessageData (Get-MarqueeEmptyRow -Format $emptyRowFormat) -InformationAction Continue

    if ($PSBoundParameters.ContainsKey('Description')) {
        $lineTokens = $Description -split ([string]::Format('(.{{{0}}})', $maximumLength)) | Where-Object { $_ }

        if ($lineTokens -is 'System.String') {
            $lineTokens = @($Description)
        }

        $tokenCount = $lineTokens.Length

        for ($i = 0; $i -lt $tokenCount; $i++) {
            Write-Information -MessageData (Get-MarqueeContentRow -Content $lineTokens[$i] -ContentLength $lineTokens[$i].Length -MaximumLength $maximumLength) -InformationAction Continue
        }

        Write-Information -MessageData (Get-MarqueeEmptyRow -Format $emptyRowFormat) -InformationAction Continue
    }

    Write-Information -MessageData (Get-MarqueeContentRow -Content $authorByline -ContentLength $authorLength -MaximumLength $maximumLength) -InformationAction Continue
    Write-Information -MessageData (Get-MarqueeEmptyRow -Format $emptyRowFormat) -InformationAction Continue
    Write-Information -MessageData (Get-MarqueeContentRow -Content $FinePrint -ContentLength $finePrintLength -MaximumLength $maximumLength) -InformationAction Continue
    Write-Information -MessageData (Get-MarqueeEmptyRow -Format $emptyRowFormat) -InformationAction Continue
    Write-Information -MessageData ($horizontalBorder + [Environment]::NewLine) -InformationAction Continue
}

Set-Alias sm Show-Marquee
Export-ModuleMember -Function Show-Marquee -Alias sm