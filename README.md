<#
.SYNOPSIS
 Module for managing Intune devices and Azure Active Directory (AAD) objects using Microsoft Graph API.

.DESCRIPTION
 This module provides a set of functions to manage Intune devices and Azure Active Directory (AAD) objects. It includes functions to retrieve 
 and set device information, manage group memberships, and handle authentication tokens. The functions utilize the Microsoft Graph API for all operations.

.FUNCTIONS
 NEW-AccessToken
 Retrieve an access token to authenticate to Microsoft Graph.

 Get-AADObjectID
 Retrieve the Azure Active Directory (AAD) Object ID for a specified user, device, or group.

 Get-IntuneDeviceID
 Retrieve the Intune Device ID for a specified device.

 Get-IntuneDeviceComplianceStatus
 Retrieve the compliance status of a specified Intune-managed device.

 Get-IntuneDeviceComplianceStatusDetails
 Retrieve detailed compliance status of a specified Intune-managed device.

 Get-IntunePrimaryUser
 Retrieve the primary user of a specified Intune-managed device.

 Invoke-GraphRequest
 Execute a Microsoft Graph API request with specified HTTP method.

 Set-IntunePrimaryUser
 Set the primary user for a specified Intune-managed device.

 Remove-IntuneDevice
 Remove a specified Intune-managed device.

 Add-AADMemberToGroup
 Add a user or device to an Azure Active Directory (AAD) group by name.

 Remove-AADMemberFromGroup
 Remove a user or device from an Azure Active Directory (AAD) group by name.

 Remove-AllAADMembersFromGroup
 Remove all users or devices from an Azure Active Directory (AAD) group by group name.

 Remove-IntunePrimaryUserDevice
 Remove the primary user from a specified Intune-managed device by device name.

 Start-SyncIntuneDevice
 Initiate a sync for a specified Intune-managed device by device name.

 Get-ManagedAppsStatus
 Retrieve the status of all managed apps on a specified Intune-managed device.

 Get-AADGroupMembers
 Lists all members of a specific group in Azure AD.

 Get-IntuneDeviceInstalledApps
 Retrieve the installed applications on a specified Intune-managed device.

 Start-ProactiveRemediation
 Initiate an on-demand Proactive Remediation script on a specified Intune-managed device.

 Get-ProactiveRemediationScriptID
 Retrieve the ID of a Proactive Remediation script from Intune.

.NOTES

 FileName: MicrosoftGraph_IntuneAAD.psm1
 Author: Marcos Junior
 Contact: @Markinhosit
 Created: 2024-11-07
 Updated: 2024-11-07

 Version history:
 1.0.0 - (2024-11-07) Script created
 1.0.1 - (2024-11-08) Add Functions: 
         Get-AADGroupMembers
         Get-ManagedAppsStatus
         Get-IntuneDeviceInstalledApps
         Get-ProactiveRemediationScriptID
         Start-ProactiveRemediation

#>
