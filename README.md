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

 Get-UpdateDriversRing
 Retrieve all approved drivers for installation in Intune and their installation status on devices.

 Get-UpdateDriversRingDetails
 Retrieve details of a Windows Driver Update Profile in Intune by its name and filter by approval status.

 Get-DriversDetailsIntune
 Retrieve detailed driver information from Intune using the Microsoft Graph API.

 Get-StatusReportDriver
 Retrieve the status of a cached report from Intune using the Microsoft Graph API.

 Get-ResultReport
 Retrieve the results of a cached report from Intune using the Microsoft Graph API.

 New-ReportDriver
 Create a new report for a specified driver from Intune using the Microsoft Graph API.

 Get-AllApprovedDrivers
 Retrieve all approved drivers from all Windows Driver Update Profiles in Intune.

 Get-AllNeedApprovedDrivers 
 Retrieve all Need approved drivers from all Windows Driver Update Profiles in Intune.

 Get-AllWindowsDevices
 Retrieve all Windows devices from Microsoft Intune, handling pagination.

 Get-AllMacOsDevices
 Retrieve all Windows devices from Microsoft Intune, handling pagination.

 Get-AllAppleMobileDevices
 Retrieve all Windows devices from Microsoft Intune, handling pagination.

 Get-AllAndroidDevices
 Retrieve all Windows devices from Microsoft Intune, handling pagination.

 Get-WindowsDevicesAD
 Retrieve specific details of all Windows devices from Azure AD, handling pagination.

 Remove-DeviceAzureID
 Remove a specified Azure AD device by its ID.

 Get-GroupSecurityEnabled
 Retrieve the securityEnabled property of a specified Azure AD group. 

 Get-IntuneDeviceLastCheckIn
 Retrieve the last check-in time of a specified Intune-managed device.

.NOTES

 FileName: MicrosoftGraph_IntuneAAD.psm1
 Author: Marcos Junior
 Contact: @Markinhosit
 Created: 2024-11-07
 Updated: 2024-11-21

 Version history:
 1.0.0 - (2024-11-07) Script created
 1.0.1 - (2024-11-08) Add Functions: Get-AADGroupMembers / Get-ManagedAppsStatus / Get-IntuneDeviceInstalledApps / Get-ProactiveRemediationScriptID / Start-ProactiveRemediation
 1.0.2 - (2024-11-12) Add Functions: Get-UpdateDriversRing / Get-UpdateDriversRingDetails 
 1.0.3 - (2024-11-13) Add Functions: Get-DriversDetailsIntune / Get-StatusReportDriver / Get-ResultReport / New-ReportDriver
 1.0.4 - (2024-11-14) Add Parameters Proxy and Proxy Credential for environment that needs and Add Function Get-AllApprovedDrivers
 1.0.4 - (2024-11-19) Fix Function Get-AllApprovedDrivers for filter names duplicate in array
 1.0.5 - (2024-11-21) Add Function: Get-AllNeedApprovedDrivers / Get-AllDrivers
                      Fix Function Get-UpdateDriversRingDetails remove the mandatory ApprovalStatus parameter
 1.0.6 - (2024-12-17) Fix Functions Get-AllNeedApprovedDrivers e Get-AllDrivers for parameter Proxy Address
 1.0.7 - (2024-12-18) Add Functions Get-AllWindowsDevices / Get-AllMacOsDevices / Get-AllAppleMobileDevices / Get-AllAndroidDevices
 1.0.8 - (2025-01-02) Add Functions Get-WindowsDevicesAD / Remove-DeviceAzureID
 1.0.9 - (2025-01-13) Add Function Get-GroupSecurityEnabled
 1.0.10 - (2025-01-14) Fix Return of Functions Get-IntuneDeviceID / Get-AADObjectID / Remove-DeviceAzureAD / Remove-DeviceIntune
 1.0.11 - (2025-01-31) Add Function Get-IntuneDeviceLastCheckIn
                       Fix Functions Get-IntuneDeviceID / Remove-DeviceIntune / Remove-DeviceAzureAD for add parameter AADID
 1.0.12 - (2025-02-10) Fix Function NEW-AccessToken
#>
