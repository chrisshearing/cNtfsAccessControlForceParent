#requires -Version 4.0

Set-StrictMode -Version Latest

Import-Module (Join-Path -Path ( Join-Path -Path ( Split-Path $PSScriptRoot -Parent ) `
            -ChildPath 'NTFSSecurity' ) `
        -ChildPath 'NTFSSecurity.psd1')



function Get-TargetResource {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $Path
    )
    $inputPath = Get-InputPath($Path)
    $AccessControlList = Get-NTFSAccess -Path $inputPath -ExcludeInherited

    $ReturnValue = @{
        Path               = $inputPath
        AccessControlCount = $AccessControlList.Count
    }

    return $ReturnValue

}

function Test-TargetResource {
    [CmdletBinding()]
    [OutputType([Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $Path
    )

    $InDesiredState = $true

    $inputPath = Get-InputPath($Path)

    if (Get-NTFSAccess -Path $inputPath -ExcludeInherited) {
        $InDesiredState = $false
    }


    if ($InDesiredState -eq $true) {
        Write-Verbose -Message 'The target resource is already in the desired state. No action is required.'
    }
    else {
        Write-Verbose -Message 'The target resource is not in the desired state.'
    }

    return $InDesiredState
}

function Set-TargetResource {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $Path
    )

    $inputPath = Get-InputPath($Path)
    Get-NTFSAccess -Path $inputPath -ExcludeInherited | Remove-NTFSAccess
}


Function Get-InputPath {
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    $returnPath = $Path

    # If Path has a environment variable, convert it to a locally usable path
    $returnPath = [System.Environment]::ExpandEnvironmentVariables($Path)
    
    return $returnPath
    
}
