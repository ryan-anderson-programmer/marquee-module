# MarqueeModule

## About

### Author

Ryan E. Anderson

---

### Description

This module contains a function for displaying information about a project.

---

### Version

0.1.0

---

### License

Apache-2.0

---

## Using the Module

The MarqueeModule exports one function, which is documented below. Please, execute the script named Build.ps1 to build dependencies and import MarqueeModule. The Build.ps1 script also runs tests and analyzes code coverage. More information about testing is provided in the next section.

### Show-Marquee (sm)

This function displays a box containing a title, the names of authors, and fine print, such as copyright information, for a project. It can also display a description of a project.

#### DefaultParameterSetName:Default

#### Parameters

##### Title

This is the title of a project.

###### Attributes

- ParameterSetName:Default,Position:0,Mandatory:$true

##### Description

This is the description of a project.

###### Attributes

- ParameterSetName:Default,Position:1,Mandatory:$false  
- ParameterSetName:Description,Position:0,Mandatory:$true  

##### Author

This is a comma-separated list of authors that contributed to a project.

###### Attributes

- ParameterSetName:Default,Position:2,Mandatory:$true

##### FinePrint

This is fine print for a project. Copyright information or other information related to terms and conditions can be assigned to this parameter.

###### Attributes

- ParameterSetName:Default,Position:3,Mandatory:$true

##### MaximumDescriptionLength

This is the maximum length of a description. This value overrides the actual length of a description. The default value for the maximum length is 128.

###### Attributes

- ParameterSetName:Default,Position:4,Mandatory:$false    
- ParameterSetName:Description,Position:1,Mandatory:$false  
- ValidateRange:\[0,256\]

#### Examples

Below are some examples for how to use the Show-Marquee command.

##### Example 1: Show a Marquee That Contains One Author

This example demonstrates how to display a marquee that contains one author.

```powershell
Show-Marquee -Title 'Project' -Author 'John Doe' -FinePrint 'Copyright (C) 2023 John Doe'
```

##### Example 2: Show a Marquee That Contains Multiple Authors

This example demonstrates how to display a marquee that contains multiple authors.

```powershell
Show-Marquee -Title 'Project' -Author 'John Doe', 'Jane Doe' -FinePrint 'Copyright (C) 2023 John and Jane Doe'
```

##### Example 3: Show a Marquee That Contains a Description

This example demonstrates how to display a marquee with a description.

```powershell
Show-Marquee -Title 'Marquee Module v0.1.0' -Author 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -Description 'This is a command for displaying information about a module or script. A title, authors, and fine print are displayed within a box when this command is invoked.' -MaximumDescriptionLength 50
```

##### Example 4: Use an Alias to Show a Marquee

This example demonstrates how to use the exported alias to show a marquee.

```powershell
sm -Title 'Marquee Module v0.1.0' -Author 'Ryan E. Anderson' -FinePrint 'Copyright (C) 2023 Ryan E. Anderson' -Description 'This is a module for displaying information about a module or script. A title, authors, and fine print are displayed within a box when this module is invoked.' -MaximumDescriptionLength 50
```

#### Remarks About Show-Marquee

- All provided information is literal and will not be trimmed.
- Words within the description will not wrap; they will be broken at the maximum length.

#### Using the Provided Windows Batch File

A Windows batch script (Show-Marquee.bat) has been provided to show a marquee. The script may be edited.

---

## Testing the Module

### Pester

Pester can be used to test this module to obtain information about code coverage. A suite of unit tests has been created to examine different contexts or scenarios and attain optimal coverage of the code. Dependencies for testing can be built using either Build.ps1 or SetUpTestEnvironment.ps1. Below is a command for analyzing code coverage with Pester.

```powershell
Invoke-Pester '.\tests' -CodeCoverage '.\marqueemodule\MarqueeModule.psm1'
```

## Building and Deploying

The Deploy.ps1 script may be used to prepare an environment for a deployment. It will execute the Build.ps1 script to create output for a deployment. Please, note that a manifest must be created manually. The CreateManifest.ps1 script is provided as a utility for conveniently creating a manifest.