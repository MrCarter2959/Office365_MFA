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
#          Enter Username           #
#                                   #
#####################################

$O365_UPN = "Enter Username"

#####################################
#                                   #
#       Connect To Office 365       #
#                                   #
#####################################

Connect-MsolService

#####################################
#                                   #
#          Find O365 User           #
#         Find MFA Options          #
#                                   #
#####################################

$O365_User = Get-MsolUser -UserPrincipalName $O365_UPN
$O365_User_MFA_Methods = $O365_User.StrongAuthenticationMethods
Write-Host "Is Default?: "$O365_User_MFA_Methods.IsDefault "    " "Method: "$O365_User_MFA_Methods.MethodType -BackgroundColor "Black" -ForegroundColor "Yellow"

#####################################
#                                   #
#         Reset MFA Options         #
#                                   #
#####################################

$Reset_MFA = @()

#####################################
#                                   #
#         Run the command           #
#                                   #
#####################################

Set-msoluser -UserPrincipalName $O365_UPN -StrongAuthenticationMethods $Reset_MFA -Verbose
