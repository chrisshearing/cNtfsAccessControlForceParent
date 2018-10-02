<#
Module manifest for the 'cNtfsAccessControlForceParent' DSC resource module.
#>

@{
    ModuleVersion     = '1.0.0'
    GUID              = '6dd73665-da0d-4945-8e9a-3a0095424a56'
    Author            = 'Chris Shearing'
    Copyright         = '(c) 2018 Chris Shearing. All rights reserved.'
    Description       = 'The cNtfsAccessControlForceParent module contains DSC resources for NTFS access control management.'
    PowerShellVersion = '4.0'
    CLRVersion        = '4.0'
    FunctionsToExport = '*'
    CmdletsToExport   = '*'
    VariablesToExport = '*'
    AliasesToExport   = '*'
    PrivateData       = @{
        PSData = @{
            Tags       = @('AccessControl', 'ACL', 'DesiredStateConfiguration', 'DirectorySecurity', 'DSC', 'FileSecurity', 'FileSystem', 'FileSystemSecurity', 'NTFS', 'PSModule')
            LicenseUri = 'https://github.com/chrisshearing/cNtfsAccessControlForceParent/blob/master/LICENSE'
            ProjectUri = 'https://github.com/chrisshearing/cNtfsAccessControlForceParent'
        }
    }
}