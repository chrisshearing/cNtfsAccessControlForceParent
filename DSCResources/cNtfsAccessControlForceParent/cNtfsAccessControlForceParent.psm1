#requires -Version 4.0

Set-StrictMode -Version Latest


function Get-TargetResource {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $Path
    )

    $acl = Get-Acl -Path $Path
    
    $AccessControlList = foreach ($access in $acl.Access) { 
        if ($access.IsInherited -eq $false) {
            Write-Verbose -Message 'Direct Permissions Found'
            $access
        }
    }

    $ReturnValue = @{
        Path              = $Path
        AccessControlList = $AccessControlList
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

    $acl = Get-Acl -Path $path

    foreach ($access in $acl.Access) { 
        if ($access.IsInherited -eq $false) {
            $InDesiredState = $false
        }
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
    [CmdletBinding(SupportsShouldProcess = $true)]
    param
    (
        [Parameter(Mandatory = $true)]
        [String]
        $Path
    )

    $acl = Get-Acl -Path $path

    foreach ($access in $acl.Access) { 
        if ($access.IsInherited -eq $false) {
            Write-Verbose -Message 'Removed Direct Permission'
            $acl.RemoveAccessRule($access) | Out-Null
        }
    }

    Set-Acl -Path $path -AclObject $acl
}
