#####################################
#                                   #
#         Import 365 Module         #
#                                   #
#####################################

If (!(Get-Module "MSOnline")) 
    {
    Install-Module MSOnline -Verbose

    Start-Sleep -Seconds 10

    Import-Module MSOnline -Verbose
    }
Else 
    {
    Import-Module MSOnline -Verbose
    }

#####################################
#                                   #
#          Connect O365             #
#                                   #
#####################################

Connect-MsolService

#####################################
#                                   #
#          Set Username             #
#          Set MFA Type             #
#                                   #
#####################################

$Enable_MFA_User = "Enter Username"
#This is the users userPrincipalName in O365

$MFA_Type = "SMS"
#This option can be SMS, Voice, OTP, Authenticator

$MFA_Options = @()
#####################################
#                                   #
#        Set MFA Options            #
#                                   #
#####################################

Foreach ($Option in $MFA_Type) 
    {

        switch ($Option){

            {$Option -like "SMS"} 
                {
                    $MFA_SMS = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                    $MFA_SMS.IsDefault = $true
                    $MFA_SMS.MethodType = "OneWaySMS"
                    Write-Host "OneWaySMS"
                    $MFA_Options += $MFA_SMS
                }
            {$Option -clike "Voice"}
                {
                    $MFA_Voice = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                    $MFA_Voice.IsDefault = $false
                    $MFA_Voice.MethodType = "TwoWayVoiceMobile"
                    Write-Host "TwoWayVoiceMobile"
                    $MFA_Options += $MFA_Voice
                }
            {$Option -contains "OTP"}
                {
                    $MFA_OTP = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                    $MFA_OTP.IsDefault = $false
                    $MFA_OTP.MethodType = "PhoneAppOTP"
                    write-Host "OTP"
                    $MFA_Options += $MFA_OTP
                }
            {$Option -contains "Authenticator"}
                {
                    $MFA_Authenticator = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
                    $MFA_Authenticator.IsDefault = $false
                    $MFA_Authenticator.MethodType = "PhoneAppNotification"
                    Write-Host "Authenticator"
                    $MFA_Options += $MFA_Authenticator
                }

            }
        }
#####################################
#                                   #
#     Set MFA Options on Account    #
#                                   #
#####################################

set-msoluser -Userprincipalname $Enable_MFA_User -StrongAuthenticationMethods $MFA_Options -Verbose
