function Set-O365MFAOptions {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [String]
        $User,
        
        [ValidateSet ("SMS", "Voice", "OTP", "Authenticator")]
        [String[]]
        $MFAType = "SMS"
    )
    
    begin {
        # Connect to MSOnline if a valid connection does not exist
        if (-not (Test-MSOLConnection)) {
            Connect-MsolService
        }
    }
    
    process {
        $MFA_Options = @()

        # Set MFA Options
        foreach ($Option in $MFA_Type) 
        {
    
            switch ($Option){
    
                "SMS"
                    {
                        $MFA_SMS = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                        $MFA_SMS.IsDefault = $true
                        $MFA_SMS.MethodType = "OneWaySMS"
                        Write-Host "OneWaySMS"
                        $MFA_Options += $MFA_SMS
                    }
                "Voice"
                    {
                        $MFA_Voice = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                        $MFA_Voice.IsDefault = $false
                        $MFA_Voice.MethodType = "TwoWayVoiceMobile"
                        Write-Host "TwoWayVoiceMobile"
                        $MFA_Options += $MFA_Voice
                    }
                "OTP"
                    {
                        $MFA_OTP = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                        $MFA_OTP.IsDefault = $false
                        $MFA_OTP.MethodType = "PhoneAppOTP"
                        write-Host "OTP"
                        $MFA_Options += $MFA_OTP
                    }
                "Authenticator"
                    {
                        $MFA_Authenticator = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                        $MFA_Authenticator.IsDefault = $false
                        $MFA_Authenticator.MethodType = "PhoneAppNotification"
                        Write-Host "Authenticator"
                        $MFA_Options += $MFA_Authenticator
                    }    
            }

        # Set MFA Options on account
        Set-MsolUser -Userprincipalname $User -StrongAuthenticationMethods $MFA_Options -Verbose
        }
    }
}