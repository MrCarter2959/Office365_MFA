function Reset-O365MFA {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $User
    )
    
    begin {
        # Connect to MSOnline if a valid connection does not exist
        if (-not (Test-MSOLConnection)) {
            Connect-MsolService
        }
    }
    
    process {
        # Find O365 User and MFA Options
        $O365_User = Get-MsolUser -UserPrincipalName $User
        $O365_User_MFA_Methods = $O365_User.StrongAuthenticationMethods

        $O365_User_MFA_Methods | Select-Object -Property IsDefault, MethodType

        # Reset MFA Options
        $Reset_MFA = @()
        Set-MsolUser -UserPrincipalName $User -StrongAuthenticationMethods $Reset_MFA -Verbose
    }
}