function Enable-O365MFA {
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
        # Set MFA Options
        $Enable_MFA = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
        $Enable_MFA.RelyingParty = "*"
        $Enable_MFA.State = "Enabled"
        $Enable_MFA_State = @($Enable_MFA)

        # Enable MFA on account
        Set-MsolUser -UserPrincipalName $User -StrongAuthenticationRequirements $Enable_MFA_State
    }
}