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
#                                   #
#####################################

$Enable_MFA_User = "Enter Username"

#####################################
#                                   #
#        Set MFA Options            #
#                                   #
#####################################

$Enable_MFA = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$Enable_MFA.RelyingParty = "*"
$Enable_MFA.State = "Enabled"
$Enable_MFA_State = @($Enable_MFA)

#####################################
#                                   #
#     Enable MFA on Account         #
#                                   #
#####################################

Set-MsolUser -UserPrincipalName $Enable_MFA_User -StrongAuthenticationRequirements $Enable_MFA_State
