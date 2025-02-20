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

Function Get-AADObjectID {
    <#
    .SYNOPSIS
     Retrieve the Azure Active Directory (AAD) Object ID for a specified user, device, or group.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the Object ID of a specified user, device, or group in Azure Active Directory (AAD). The function requires the name of the object, its type (User, Device, or Group), and a valid authentication token.

    .PARAMETER Name
     The name of the user, device, or group for which to retrieve the Object ID.

    .PARAMETER Type
     The type of the object. Valid values are "User", "Device", and "Group".

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-AADObjectID -Name "john.doe" -Type "User" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    .EXAMPLE
     Get-AADObjectID -Name "Device123" -Type "Device" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    .EXAMPLE
     Get-AADObjectID -Name "FinanceGroup" -Type "Group" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="ByName")]
        [string]$Name,
        [Parameter(Mandatory=$true, ParameterSetName="ByAADID")]
        [string]$AADID,
        [Parameter(Mandatory)]
        [ValidateSet("User", "Device", "Group")]
        [string]$Type,
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    if ($Type -eq "User") {
        if($Name -match '@Corp.caixa.gov.br'){
            $UserPrincipalName = $Name
        }else{
            $UserPrincipalName = $Name + '@corp.caixa.gov.br'
        }
        $uri = "https://graph.microsoft.com/beta/users?`$filter=userPrincipalName eq '$UserPrincipalName'"
    } elseif ($Type -eq "Device") {
        if($AADID){
            $uri = "https://graph.microsoft.com/beta/devices?`$filter=deviceId eq '$AADID'"
        }else{
            $uri = "https://graph.microsoft.com/beta/devices?`$filter=displayName eq '$Name'"
        }
    } elseif ($Type -eq "Group") {
        $uri = "https://graph.microsoft.com/beta/groups?`$filter=startswith(displayName,'$Name')"
    }

    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -ErrorAction SilentlyContinue
        }
        if ($response.value) {
            return $response.value[0].id
        } else {
            Write-Error "$Type not found."
        }
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

function Get-GroupSecurityEnabled {
    <#
    .SYNOPSIS
     Retrieve the securityEnabled property of a specified Azure AD group.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the securityEnabled property of a specified group in Azure AD.

    .PARAMETER GroupId
     The Object ID of the group for which to retrieve the securityEnabled property.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-GroupSecurityEnabled -GroupId "12345678-1234-1234-1234-123456789012" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$GroupName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        $GroupId = Get-AADObjectID -Type Group -Name $GroupName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $GroupId = Get-AADObjectID -Type Group -Name $GroupName -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/v1.0/groups/$GroupId"

    try {
        if ($ProxyAddress) {
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        } else {
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        return $response.securityEnabled
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-IntuneDeviceID {
    <#
    .SYNOPSIS
     Retrieve the Intune Device ID for a specified device.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the Device ID of a specified device managed by Intune. The function requires the name of the device and a valid authentication token.

    .PARAMETER DeviceName
     The name of the device for which to retrieve the Device ID.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-IntuneDeviceID -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="ByDeviceName")]
        [string]$DeviceName,
        [Parameter(Mandatory=$true, ParameterSetName="ByAADID")]
        [string]$AADID,
        [Parameter(Mandatory=$true)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    if($AADID){
        $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices?`$filter=azureADDeviceId eq '$AADID'"
    }elseif($DeviceName){
        $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices?`$filter=deviceName eq '$DeviceName'"
    }
    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -ErrorAction SilentlyContinue
        }
        
        if ($response.value) {
            return $response.value[0].id
        } else {
            Write-Error "Device not found."
        }
    } catch {
        #Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-IntuneDeviceComplianceStatus {
    <#
    .SYNOPSIS
     Retrieve the compliance status of a specified Intune-managed device.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the compliance status of a specified device managed by Intune. The function requires the device ID and a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .PARAMETER DeviceId
     The ID of the device for which to retrieve the compliance status.

    .EXAMPLE
     Get-IntuneDeviceComplianceStatus -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..." -DeviceId "12345"

    #>
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        $DeviceId = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $DeviceId = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$DeviceId"

    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        return $response | Select-Object DeviceName, ComplianceState
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-IntuneDeviceComplianceStatusDetails {
    <#
    .SYNOPSIS
     Retrieve detailed compliance status of a specified Intune-managed device.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve detailed compliance status information for a specified device managed by Intune. The function filters the response to include only relevant compliance policies. It requires the device ID and a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .PARAMETER DeviceId
     The ID of the device for which to retrieve the detailed compliance status.

    .EXAMPLE
     Get-IntuneDeviceComplianceStatusDetails -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..." -DeviceId "12345"

    #>
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        $DeviceId = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $DeviceId = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$DeviceId/deviceCompliancePolicyStates"

    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $filteredResponse = $response.value | Where-Object {$_.userId -eq "00000000-0000-0000-0000-000000000000" -or $_.displayName -eq "Default Device Compliance Policy"}
        Return $filteredResponse | Select-Object @{Name="PolicyName";Expression={$_.displayName}}, @{Name="ComplianceState";Expression={$_.state}}
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-IntunePrimaryUser {
    <#
    .SYNOPSIS
     Retrieve the primary user of a specified Intune-managed device.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the primary user associated with a specified device managed by Intune. The function requires the Intune device ID and a valid authentication token.

    .PARAMETER IntuneID
     The ID of the Intune-managed device for which to retrieve the primary user.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-IntunePrimaryUser -IntuneID "12345" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    $URI = "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices('$IntuneID')/users"
    try {
        if($ProxyAddress){
            $Results = Invoke-RestMethod -Uri $URI -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $Results = Invoke-RestMethod -Uri $URI -Method Get -Headers $headers
        }
       
        if ($Results.value -and $Results.value.Count -gt 0) {
            $PrimaryUser = $Results.value
            if ($PrimaryUser) {
                return $PrimaryUser | Select-Object id, displayName
            } else {
                Write-Output "No primary user found for this device."
            }
        } else {
            Write-Output "No users found for this device."
        }
    } catch {
        Write-Error -Message "Error - $($_.Exception.Message)"
        Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
        Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}

Function Get-ManagedAppsStatus {
    <#
    .SYNOPSIS
     Retrieve the status of all managed apps on a specified Intune-managed device.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the status of all managed apps on a specified device managed by Intune. It filters the apps to show only those linked to the primary user of the device. The function requires the device name and a valid authentication token.

    .PARAMETER DeviceName
     The name of the Intune-managed device for which to retrieve the managed apps status.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-ManagedAppsStatus -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    # Obter o ID do dispositivo Intune e usuário primário do dispositivo
    if($ProxyAddress){
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        $PrimaryUser = Get-IntunePrimaryUser -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        $UserID = $PrimaryUser.id
    }else{
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
        $PrimaryUser = Get-IntunePrimaryUser -DeviceName $DeviceName -Token $Token
        $UserID = $PrimaryUser.id
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    # Definir a URI para obter os aplicativos gerenciados do dispositivo
    $uri = "https://graph.microsoft.com/beta/users/$UserID/mobileAppIntentAndStates/$IntuneID`?`$select=mobileAppList"
    try {
        # Fazer a requisição para obter os aplicativos gerenciados
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $managedApps = $response.mobileAppList
        # Retornar o nome do aplicativo e o status de conformidade
        return $managedApps | Select-Object @{Name="AppName";Expression={$_.displayName}}, @{Name="DeployType";Expression={$_.mobileAppIntent}}, @{Name="Status";Expression={$_.installState}}
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-AADGroupMembers {
    <#
    .SYNOPSIS
     Lists all members of a specific group in Azure AD.

    .DESCRIPTION
     This function retrieves a list of all members of a specific group in Azure AD using the Microsoft Graph API. It requires a valid authentication token and the group name.

    .PARAMETER GroupName
     The name of the group whose members will be listed.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-AADGroupMembers -GroupName "GroupName" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    param (
        [Parameter(Mandatory)]
        [string]$GroupName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    if($ProxyAddress){
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token
    }
    $uri = "https://graph.microsoft.com/v1.0/groups/$GroupID/members"
    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $members = $response.value | Select-Object id, displayName
        Write-Output $members
    } catch {
        Write-Error "Error listing group members: $($_.Exception.Message)"
    }
}

Function Get-IntuneDeviceInstalledApps {
    <#
    .SYNOPSIS
     Retrieve the installed applications on a specified Intune-managed device.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the installed applications on a specified device managed by Intune. It requires the device name and a valid authentication token.

    .PARAMETER DeviceName
     The name of the Intune-managed device for which to retrieve the installed applications.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-IntuneDeviceInstalledApps -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    # Obter o ID do dispositivo Intune
    if($ProxyAddress){
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    # Definir a URI para obter os aplicativos instalados no dispositivo
    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$IntuneID/detectedApps"
    try {
        # Fazer a requisição para obter os aplicativos instalados no dispositivo
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $installedApps = $response.value
        # Retornar os aplicativos instalados
        return $installedApps | Select-Object @{Name="AppName";Expression={$_.displayName}}, @{Name="Version";Expression={$_.version}}
    } catch {
        Write-Error "Error retrieving installed apps: $($_.Exception.Message)"
    }
}

Function Get-RemediationScriptID {
    <#
    .SYNOPSIS
     Retrieve the ID of a Proactive Remediation script from Intune.

    .DESCRIPTION
     This function sends a request to the Microsoft Graph API to retrieve the ID of a Proactive Remediation script managed by Intune. It requires the script name and a valid authentication token.

    .PARAMETER ScriptName
     The name of the Proactive Remediation script whose ID you want to retrieve.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-ProactiveRemediationScriptID -ScriptName "MyProactiveRemediationScript" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ScriptName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    # Definir a URI para buscar os scripts de Proactive Remediation
    $uri = "https://graph.microsoft.com/beta/deviceManagement/deviceHealthScripts"
    try {
        # Fazer a requisição para obter os scripts de Proactive Remediation
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        # Filtrar o script pelo nome e obter o ID
        $script = $response.value | Where-Object { $_.displayName -eq $ScriptName }
        if ($script) {
            Write-Output $script.id
        } else {
            Write-Error "Script not found: $ScriptName"
        }
    } catch {
        Write-Error "Error retrieving Proactive Remediation script ID: $($_.Exception.Message)"
    }
}

Function Get-UpdateDriversRing {
<#
.SYNOPSIS
 Retrieve all approved drivers for installation in Intune and their installation status on devices.

.DESCRIPTION
 This function sends a request to the Microsoft Graph API to retrieve all approved drivers for installation in Intune and provides the number of devices on which each driver is installed and the number of devices pending installation. It requires a valid authentication token.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 Get-IntuneApprovedDrivers -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    # Definir a URI para buscar os perfis de atualização de drivers do Windows
    $uri = "https://graph.microsoft.com/beta/deviceManagement/windowsDriverUpdateProfiles"
    try {
        # Fazer a requisição para obter os perfis de atualização de drivers do Windows
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $profiles = $response.value
        # Processar os dados dos perfis de drivers
        $driverStatus = $profiles | ForEach-Object {
            [PSCustomObject]@{
                ProfileID        = $_.id
                ProfileName      = $_.displayName
                InstalledDevices = $_.installedDeviceCount
                PendingDevices   = $_.pendingDeviceCount
            }
        }
        return $driverStatus
    }catch{
        Write-Error "Error retrieving approved drivers: $($_.Exception.Message)"
    }
}

Function Get-UpdateDriversRingDetails {
<#
.SYNOPSIS
 Retrieve details of a Windows Driver Update Profile in Intune by its name and filter by approval status.

.DESCRIPTION
 This function sends a request to the Microsoft Graph API to retrieve details of a Windows Driver Update Profile in Intune by its name and filters the results by the specified approval status. It requires the profile name, approval status, and a valid authentication token.

.PARAMETER ProfileName
 The name of the Windows Driver Update Profile whose details you want to retrieve.

.PARAMETER ApprovalStatus
 The approval status to filter the drivers (needsReview or approved).

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 Get-DriverUpdateProfileDetails -ProfileName "MyDriverUpdateProfile" -ApprovalStatus "approved" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ProfileName,
        [Parameter()]
        [ValidateSet("needsReview", "approved")]
        [string]$ApprovalStatus,
        [Parameter()]
        [ValidateSet("recommended", "other")]
        [string]$Category,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        $ID = Get-UpdateDriversRing -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential | Where-Object { $_.ProfileName -eq $ProfileName }
    }else{
        $ID = Get-UpdateDriversRing -Token $Token | Where-Object { $_.ProfileName -eq $ProfileName }
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    if($Category){
        $uri = "https://graph.microsoft.com/beta/deviceManagement/windowsDriverUpdateProfiles/$($ID.ProfileID)/driverInventories?`$filter=category%20eq%20%27$Category%27"
    }else{
        $uri = "https://graph.microsoft.com/beta/deviceManagement/windowsDriverUpdateProfiles/$($ID.ProfileID)/driverInventories"
    }
    # Definir a URI para buscar os detalhes do perfil de atualização de drivers do Windows
    try {
        # Fazer a requisição para obter os detalhes do perfil de atualização de drivers do Windows
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $drivers = $response.value
        # Filtrar e processar os dados dos drivers
        if($ApprovalStatus){
            $driverDetails = $drivers | Where-Object {$_.approvalStatus -eq $ApprovalStatus} 
        }else{
            $driverDetails = $drivers 
        }
        $DriverStatus = $driverDetails | ForEach-Object {
        [PSCustomObject]@{
                Name                  = $_.name
                Version               = $_.version
                Manufacturer          = $_.manufacturer
                DriverClass           = $_.driverClass
                ApplicableDeviceCount = $_.applicableDeviceCount
                ApprovalStatus        = $_.approvalStatus
                Category              = $_.category
                deployDateTime        = $_.deployDateTime
                releaseDateTime       = $_.releaseDateTime
            }
        }
        return $DriverStatus
    } catch {
        Write-Error "Error retrieving Driver Update Profile details: $($_.Exception.Message)"
    }
}

Function Get-DriversDetailsIntune {
    <#
    .SYNOPSIS
     Retrieve detailed driver information from Intune using the Microsoft Graph API.

    .DESCRIPTION
     This function retrieves detailed information about drivers from Intune using the Microsoft Graph API. It requires a valid authentication token and the name of the driver to search for.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .PARAMETER DriverName
     The name of the driver to search for in Intune.

    .EXAMPLE
     Get-DriversDetailsIntune -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..." -DriverName "HP Inc. - SoftwareComponent - 4.8.7.0"

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter(Mandatory)]
        [string]$DriverName,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    
    $body = @{
        filter = ""
        name = "DriverUpdateInventory"
        OrderBy = $null
        search = $DriverName
        Select = $null
        Skip  = 0
        Top   = 1000
    } | ConvertTo-Json 

    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/getReportFilters" -Method Post -Headers $headers -Body $body -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/getReportFilters" -Method Post -Headers $headers -Body $body
        }
            $response = $response.Values
            $formattedResponse = $response | ForEach-Object {
                $lines = $_ -split "`n"
                [PSCustomObject]@{
                    Category       = $lines[0]
                    Name           = $lines[1]
                    Manufacturer   = $lines[2]
                    Class          = $lines[3]
                    Version        = $lines[4]
                    Date           = $lines[5]
                }
            }
            # Group by Category and select the first object from each group
            $uniqueCategories = $formattedResponse | Group-Object -Property Category | ForEach-Object { $_.Group[0] }
            return $uniqueCategories
    } catch {
        Write-Error -Message "Error - $($_.Exception.Message)"
        Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
        Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}

Function Get-StatusReportDriver {
    <#
    .SYNOPSIS
     Retrieve the status of a cached report from Intune using the Microsoft Graph API.

    .DESCRIPTION
     This function retrieves the status of a cached report from Intune using the Microsoft Graph API. It requires a valid authentication token to access the API.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-StatusReportDriver -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    
    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/cachedReportConfigurations('DriverUpdateDeviceStatusByDriver_00000000-0000-0000-0000-000000000001')" -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/cachedReportConfigurations('DriverUpdateDeviceStatusByDriver_00000000-0000-0000-0000-000000000001')" -Method Get -Headers $headers
        }
        Return $response 
    } catch {
        Write-Error -Message "Error - $($_.Exception.Message)"
        Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
        Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}

Function Get-ResultReport {
    <#
    .SYNOPSIS
     Retrieve the results of a cached report from Intune using the Microsoft Graph API.

    .DESCRIPTION
     This function retrieves the results of a cached report from Intune using the Microsoft Graph API. It handles pagination to ensure all results are retrieved. It requires a valid authentication token to access the API.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-ResultReport -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    $allResults = @()
    $skip = 0
    $top = 50
    $morePages = $true
    try {
        while ($morePages) {
            $body = @{
                id = "DriverUpdateDeviceStatusByDriver_00000000-0000-0000-0000-000000000001"
                OrderBy = @()
                search = ""
                Select = @("DeviceName", "UPN", "DeviceId", "AadDeviceId", "CurrentDeviceUpdateSubstateTime", "PolicyName", "CurrentDeviceUpdateState", "CurrentDeviceUpdateSubstate", "AggregateState", "HighestPriorityAlertSubType", "LastWUScanTime")
                skip = $skip
                top = $top
                filter = ""  
            } | ConvertTo-Json 
            if($ProxyAddress){
                Start-Sleep 10
                $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/getCachedReport" -Method POST -Headers $headers -Body $body -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            }else{
                Start-Sleep 10
                $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/getCachedReport" -Method POST -Headers $headers -Body $body
            }
            $responseValues = $response.Values
            $formattedResponse = $responseValues | ForEach-Object {
                $lines = $_ -split "`n"
                [PSCustomObject]@{
                    AadDeviceId                     = $lines[0]
                    AggregateState                  = $lines[1]
                    AggregateState_loc              = $lines[2]
                    CurrentDeviceUpdateState        = $lines[3]
                    CurrentDeviceUpdateState_loc    = $lines[4]
                    CurrentDeviceUpdateSubstate     = $lines[5]
                    CurrentDeviceUpdateSubstate_loc = $lines[6]
                    CurrentDeviceUpdateSubstateTime = $lines[7]
                    DeviceId                        = $lines[8]
                    DeviceName                      = $lines[9]
                    HighestPriorityAlertSubType     = $lines[10]
                    HighestPriorityAlertSubType_loc = $lines[11]
                    LastWUScanTime                  = $lines[12] 
                    PolicyName                      = $lines[13]
                    UPN                             = $lines[14]
                }
            }
            $allResults += $formattedResponse
            if ($responseValues.Count -lt $top) {
                $morePages = $false
            } else {
                $skip += $top
                #$top = $top + 50
            }
        }
        return $allResults
    } catch {
        Write-Error -Message "Error - $($_.Exception.Message)"
        Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
        Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}

Function Get-AllApprovedDrivers {
<#
.SYNOPSIS
 Retrieve all approved drivers from all Windows Driver Update Profiles in Intune.

.DESCRIPTION
 This function sends requests to the Microsoft Graph API to retrieve all approved drivers from all Windows Driver Update Profiles in Intune. It combines the results into a single collection, including the driver name, version, approval status, and the profile name to which each driver belongs. It requires a valid authentication token.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.PARAMETER ProxyAddress
 Optional. The address of the proxy server to use for the requests.

.PARAMETER ProxyCredential
 Optional. The credentials to use for the proxy server.

.EXAMPLE
 $Token = "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
 $ApprovalStatus = "approved"
 $allApprovedDrivers = Get-AllApprovedDrivers -Token $Token -ApprovalStatus $ApprovalStatus
 $allApprovedDrivers | Format-Table -AutoSize

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $allDrivers = @()

    # Obter todos os perfis de atualização de drivers
    if($ProxyAddress){
        $profiles = Get-UpdateDriversRing -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $profiles = Get-UpdateDriversRing -Token $Token
    }

    foreach ($profile in $profiles) {
        # Obter os detalhes dos drivers aprovados para cada perfil
        if($ProxyAddress){
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -ApprovalStatus approved -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -ApprovalStatus approved -Token $Token
        }
        foreach ($driver in $drivers) {
            if ($allDrivers.Name -notcontains $driver.Name) {
                $allDrivers += [PSCustomObject]@{
                    Name            = $driver.Name
                    Version         = $driver.Version
                    Manufacturer    = $driver.Manufacturer
                    DriverClass     = $driver.DriverClass 
                    ApprovalStatus  = $driver.ApprovalStatus
                    ProfileName     = $profile.ProfileName
                    deployDateTime  = $Driver.deployDateTime
                    releaseDateTime = $driver.releaseDateTime

                }
            }
        }
    }

    return $allDrivers
}

Function Get-AllNeedApprovedDrivers {
<#
.SYNOPSIS
 Retrieve all Need approved drivers from all Windows Driver Update Profiles in Intune.

.DESCRIPTION
 This function sends requests to the Microsoft Graph API to retrieve all Need approved drivers from all Windows Driver Update Profiles in Intune. It combines the results into a single collection, including the driver name, version, approval status, and the profile name to which each driver belongs. It requires a valid authentication token.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.PARAMETER ProxyAddress
 Optional. The address of the proxy server to use for the requests.

.PARAMETER ProxyCredential
 Optional. The credentials to use for the proxy server.

.EXAMPLE
 $Token = "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
 $allNeedApprovedDrivers = Get-AllApprovedDrivers -Token $Token
 $allNeedApprovedDrivers | Format-Table -AutoSize

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $allDrivers = @()
    # Obter todos os perfis de atualização de drivers
    if($ProxyAddress){
        $profiles = Get-UpdateDriversRing -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $profiles = Get-UpdateDriversRing -Token $Token
    }
    foreach ($profile in $profiles) {
        # Obter os detalhes dos drivers aprovados para cada perfil
        if($ProxyAddress){
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -ApprovalStatus needsReview -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -ApprovalStatus needsReview -Token $Token
        }
        foreach ($driver in $drivers) {
            if ($allDrivers.Name -notcontains $driver.Name) {
                $allDrivers += [PSCustomObject]@{
                    Name            = $driver.Name
                    Version         = $driver.Version
                    Manufacturer    = $driver.Manufacturer
                    DriverClass     = $driver.DriverClass 
                    ApprovalStatus  = $driver.ApprovalStatus
                    ProfileName     = $profile.ProfileName
                    deployDateTime  = $Driver.deployDateTime
                    releaseDateTime = $driver.releaseDateTime

                }
            }
        }
    }

    return $allDrivers
}

Function Get-AllDrivers {
<#
.SYNOPSIS
 Retrieve all drivers from all Windows Driver Update Profiles in Intune.

.DESCRIPTION
 This function sends requests to the Microsoft Graph API to retrieve all Need approved drivers from all Windows Driver Update Profiles in Intune. It combines the results into a single collection, including the driver name, version, approval status, and the profile name to which each driver belongs. It requires a valid authentication token.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.PARAMETER ProxyAddress
 Optional. The address of the proxy server to use for the requests.

.PARAMETER ProxyCredential
 Optional. The credentials to use for the proxy server.

.EXAMPLE
 $Token = "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
 $allDrivers = Get-AllApprovedDrivers -Token $Token 
 $allDrivers | Format-Table -AutoSize

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $allDrivers = @()
    # Obter todos os perfis de atualização de drivers
    if($ProxyAddress){
        $profiles = Get-UpdateDriversRing -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $profiles = Get-UpdateDriversRing -Token $Token
    }
    foreach ($profile in $profiles) {
        # Obter os detalhes dos drivers aprovados para cada perfil
        if($ProxyAddress){
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -Token $Token
        }
        foreach ($driver in $drivers) {
            # Verificar se o driver já está na lista para o perfil específico
            if (-not ($allDrivers | Where-Object { $_.Name -eq $driver.Name -and $_.ProfileName -eq $profile.ProfileName })) {
                $allDrivers += [PSCustomObject]@{
                    Name                  = $driver.Name
                    Version               = $driver.Version
                    Manufacturer          = $driver.Manufacturer
                    DriverClass           = $driver.DriverClass 
                    ApprovalStatus        = $driver.ApprovalStatus
                    ProfileName           = $profile.ProfileName
                    deployDateTime        = $driver.deployDateTime
                    releaseDateTime       = $driver.releaseDateTime
                    applicableDeviceCount = $driver.applicableDeviceCount
                }
            }
        }
    }

    return $allDrivers
}

Function Get-AllRecommendedDrivers {
<#
.SYNOPSIS
 Retrieve all drivers from all Windows Driver Update Profiles in Intune.

.DESCRIPTION
 This function sends requests to the Microsoft Graph API to retrieve all Need approved drivers from all Windows Driver Update Profiles in Intune. It combines the results into a single collection, including the driver name, version, approval status, and the profile name to which each driver belongs. It requires a valid authentication token.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.PARAMETER ProxyAddress
 Optional. The address of the proxy server to use for the requests.

.PARAMETER ProxyCredential
 Optional. The credentials to use for the proxy server.

.EXAMPLE
 $Token = "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
 $allDrivers = Get-AllApprovedDrivers -Token $Token 
 $allDrivers | Format-Table -AutoSize

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $allDrivers = @()
    # Obter todos os perfis de atualização de drivers
    if($ProxyAddress){
        $profiles = Get-UpdateDriversRing -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $profiles = Get-UpdateDriversRing -Token $Token
    }
    foreach ($profile in $profiles) {
        # Obter os detalhes dos drivers aprovados para cada perfil
        if($ProxyAddress){
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential -Category recommended
        }else{
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -Token $Token -Category recommended
        }
        foreach ($driver in $drivers) {
            # Verificar se o driver já está na lista para o perfil específico
            if (-not ($allDrivers | Where-Object { $_.Name -eq $driver.Name -and $_.ProfileName -eq $profile.ProfileName })) {
                $allDrivers += [PSCustomObject]@{
                    Name                  = $driver.Name
                    Version               = $driver.Version
                    Manufacturer          = $driver.Manufacturer
                    DriverClass           = $driver.DriverClass 
                    ApprovalStatus        = $driver.ApprovalStatus
                    ProfileName           = $profile.ProfileName
                    deployDateTime        = $driver.deployDateTime
                    releaseDateTime       = $driver.releaseDateTime
                    applicableDeviceCount = $driver.applicableDeviceCount
                }
            }
        }
    }

    return $allDrivers
}

Function Get-AllOtherDrivers {
<#
.SYNOPSIS
 Retrieve all drivers from all Windows Driver Update Profiles in Intune.

.DESCRIPTION
 This function sends requests to the Microsoft Graph API to retrieve all Need approved drivers from all Windows Driver Update Profiles in Intune. It combines the results into a single collection, including the driver name, version, approval status, and the profile name to which each driver belongs. It requires a valid authentication token.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.PARAMETER ProxyAddress
 Optional. The address of the proxy server to use for the requests.

.PARAMETER ProxyCredential
 Optional. The credentials to use for the proxy server.

.EXAMPLE
 $Token = "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
 $allDrivers = Get-AllApprovedDrivers -Token $Token 
 $allDrivers | Format-Table -AutoSize

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $allDrivers = @()
    # Obter todos os perfis de atualização de drivers
    if($ProxyAddress){
        $profiles = Get-UpdateDriversRing -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $profiles = Get-UpdateDriversRing -Token $Token
    }
    foreach ($profile in $profiles) {
        # Obter os detalhes dos drivers aprovados para cada perfil
        if($ProxyAddress){
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential -Category other
        }else{
            $drivers = Get-UpdateDriversRingDetails -ProfileName $profile.ProfileName -Token $Token -Category other
        }
        foreach ($driver in $drivers) {
            # Verificar se o driver já está na lista para o perfil específico
            if (-not ($allDrivers | Where-Object { $_.Name -eq $driver.Name -and $_.ProfileName -eq $profile.ProfileName })) {
                $allDrivers += [PSCustomObject]@{
                    Name                  = $driver.Name
                    Version               = $driver.Version
                    Manufacturer          = $driver.Manufacturer
                    DriverClass           = $driver.DriverClass 
                    ApprovalStatus        = $driver.ApprovalStatus
                    ProfileName           = $profile.ProfileName
                    deployDateTime        = $driver.deployDateTime
                    releaseDateTime       = $driver.releaseDateTime
                    applicableDeviceCount = $driver.applicableDeviceCount
                }
            }
        }
    }

    return $allDrivers
}

Function Get-AllWindowsDevices {
    <#
    .SYNOPSIS
     Retrieve all Windows devices from Microsoft Intune, handling pagination.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve all devices running Windows in Microsoft Intune, handling pagination to ensure all devices are retrieved. The function requires a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-AllWindowsDevices -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices?`$filter=operatingSystem eq 'Windows'"
    $allDevices = @()

    try {
        do {
            if ($ProxyAddress) {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            } else {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
            }

            if ($response.value) {
                $allDevices += $response.value
                $uri = $response.'@odata.nextLink'
            } else {
                Write-Error "No Windows devices found."
                break
            }
        } while ($uri -ne $null)

        return $allDevices
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-AllMacOsDevices {
    <#
    .SYNOPSIS
     Retrieve all Windows devices from Microsoft Intune, handling pagination.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve all devices running Windows in Microsoft Intune, handling pagination to ensure all devices are retrieved. The function requires a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-AllWindowsDevices -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices?`$filter=operatingSystem eq 'MacOS'"
    $allDevices = @()

    try {
        do {
            if ($ProxyAddress) {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            } else {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
            }

            if ($response.value) {
                $allDevices += $response.value
                $uri = $response.'@odata.nextLink'
            } else {
                Write-Error "No Windows devices found."
                break
            }
        } while ($uri -ne $null)

        return $allDevices
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-AllAppleMobileDevices {
    <#
    .SYNOPSIS
     Retrieve all Windows devices from Microsoft Intune, handling pagination.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve all devices running Windows in Microsoft Intune, handling pagination to ensure all devices are retrieved. The function requires a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-AllWindowsDevices -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices?`$filter=operatingSystem eq 'iOS' or operatingSystem eq 'iPadOS'"
    $allDevices = @()

    try {
        do {
            if ($ProxyAddress) {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            } else {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
            }

            if ($response.value) {
                $allDevices += $response.value
                $uri = $response.'@odata.nextLink'
            } else {
                Write-Error "No Windows devices found."
                break
            }
        } while ($uri -ne $null)

        return $allDevices
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-AllAndroidDevices {
    <#
    .SYNOPSIS
     Retrieve all Windows devices from Microsoft Intune, handling pagination.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve all devices running Windows in Microsoft Intune, handling pagination to ensure all devices are retrieved. The function requires a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-AllWindowsDevices -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices?`$filter=operatingSystem eq 'Android'"
    $allDevices = @()

    try {
        do {
            if ($ProxyAddress) {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            } else {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
            }

            if ($response.value) {
                $allDevices += $response.value
                $uri = $response.'@odata.nextLink'
            } else {
                Write-Error "No Windows devices found."
                break
            }
        } while ($uri -ne $null)

        return $allDevices
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-WindowsDevicesAD {
    <#
    .SYNOPSIS
     Retrieve specific details of all Windows devices from Azure AD, handling pagination.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve specific details (Name, OS, Version, Join Type, Owner, MDM, Compliance, Registered) of all devices running Windows in Azure AD, handling pagination to ensure all devices are retrieved. The function requires a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Get-WindowsDevicesDetails -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    #$uri = "https://graph.microsoft.com/v1.0/devices?`$filter=operatingSystem eq 'Windows'"
    $uri = "https://graph.microsoft.com/v1.0/devices?`$filter=operatingSystem eq 'Windows'"
    $allDevices = @()

    try {
        do {
            if ($ProxyAddress) {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            } else {
                $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
            }

            if ($response.value) {
                $allDevices += $response.value | Select-Object -Property accountEnabled,displayName,operatingSystem,operatingSystemVersion,trustType,deviceOwnership,isCompliant,registrationDateTime,approximateLastSignInDateTime
                $uri = $response.'@odata.nextLink'
            } else {
                Write-Error "No Windows devices found."
                break
            }
        } while ($uri -ne $null)

        return $allDevices
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-IntuneDeviceLastCheckIn {
    <#
    .SYNOPSIS
     Retrieve the last check-in time of a specified Intune-managed device.

    .DESCRIPTION
     This function queries the Microsoft Graph API to retrieve the last check-in time for a specified device managed by Intune. It requires the device ID and a valid authentication token.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .PARAMETER DeviceName
     The name of the device for which to retrieve the last check-in time.

    .EXAMPLE
     Get-IntuneDeviceLastCheckIn -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..." -DeviceName "Device123"

    #>
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        $DeviceId = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $DeviceId = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$DeviceId"

    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $lastCheckIn = $response.lastSyncDateTime
        Return $lastCheckIn
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Set-IntunePrimaryUser {
    <#
    .SYNOPSIS
     Set the primary user for a specified Intune-managed device.

    .DESCRIPTION
     This function assigns a primary user to a specified device managed by Intune. It requires the device name, user name, and a valid authentication token. The function retrieves the Intune device ID and the Azure Active Directory (AAD) user ID before making the assignment.

    .PARAMETER DeviceName
     The name of the Intune-managed device for which to set the primary user.

    .PARAMETER UserName
     The name of the user to be set as the primary user for the device.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .PARAMETER ProxyAddress
     The address of the proxy server.

    .PARAMETER ProxyCredential
     The credentials for the proxy server.

    .EXAMPLE
     Set-IntunePrimaryUser -DeviceName "Laptop123" -UserName "john.doe" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..." -ProxyAddress "http://proxy:80" -ProxyCredential $Cred

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$UserName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    # Retrieve Intune device ID and user ID
    if($ProxyAddress){
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue
        $UserID = Get-AADObjectID -Type User -Name $UserName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue
    }else{
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token 
        $UserID = Get-AADObjectID -Type User -Name $UserName -Token $Token
    }
    if (-not $IntuneID) {
        return "Device '$DeviceName' not found."
    }
    if (-not $UserID) {
        return "User '$UserName' not found."
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    $Body = @{
        "@odata.id" = "https://graph.microsoft.com/beta/users/$UserID"
    } | ConvertTo-Json
    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/manageddevices('$IntuneID')/users/`$ref" -Method Post -Headers $headers -Body $Body -Proxy $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue
            $PrimaryUser = Get-IntunePrimaryUser -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/manageddevices('$IntuneID')/users/`$ref" -Method Post -Headers $headers -Body $Body
            $PrimaryUser = Get-IntunePrimaryUser -DeviceName $DeviceName -Token $Token 
        }
        if($($PrimaryUser.id) -eq $UserID){
            return "Primary user set successfully."
        }
    } catch {
        Write-Error -Message "Error setting primary user: $($_.Exception.Message)"
        Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
        Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}

Function NEW-AccessToken {
    <#
    .SYNOPSIS
     Retrieve an access token to authenticate to Microsoft Graph.

    .DESCRIPTION
     This function retrieves an access token for authenticating to Microsoft Graph using client credentials. It requires the tenant name, client ID, and client secret.

    .PARAMETER TenantName
     The tenant ID in the format: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX.

    .PARAMETER ClientID
     The application ID of an Azure AD native application registration.

    .PARAMETER ClientSecret
     The secret of the app registration.

    .PARAMETER ProxyAddress
     The address of the proxy server.

    .PARAMETER ProxyCredential
     The credentials for the proxy server.

    .EXAMPLE
     NEW-AccessToken -TenantName "your-tenant-id" -ClientID "your-client-id" -ClientSecret "your-client-secret" -ProxyAddress "http://proxy:80" -ProxyCredential $Cred

    #>
    param (
        [Parameter(Mandatory)]
        [string]$TenantName,
        [Parameter(Mandatory)]
        [string]$ClientID,
        [Parameter(Mandatory)]
        [string]$ClientSecret,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $TokenFile = "$env:tmp\GraphToken_CEAUS04_$TenantName.json"

    # Verifica se o token já existe e é válido
    if (Test-Path $TokenFile) {
        $Token = Get-Content -Path $TokenFile | ConvertFrom-Json
        $CurrentTime = (Get-Date).ToUniversalTime()

        if ($CurrentTime -lt $Token.ExpiracaoToken) {
            return $Token.access_token
        }
    }

    $ReqTokenBody = @{
        Grant_Type    = "client_credentials"
        client_Id     = $ClientID
        Client_Secret = $ClientSecret
        Scope         = "https://graph.microsoft.com/.default"
    }

    if ($ProxyAddress) {
        $TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody -Proxy $ProxyAddress -ProxyCredential $ProxyCredential -UseBasicParsing
    } else {
        $TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody -UseBasicParsing
    }

    $TokenResponseMG = $TokenResponse.access_token
    $ExpiracaoToken = ((Get-Date).AddMinutes(59)).ToUniversalTime()

    # Salva o token e a data de expiração em um arquivo
    $TokenData = [PSCustomObject]@{
        access_token  = $TokenResponseMG
        ExpiracaoToken = $ExpiracaoToken
    }

    $TokenData | ConvertTo-Json | Set-Content -Path $TokenFile

    return $TokenResponseMG
}

Function New-ReportDriver {
    <#
    .SYNOPSIS
     Create a new report for a specified driver from Intune using the Microsoft Graph API.

    .DESCRIPTION
     This function creates a new report for a specified driver from Intune using the Microsoft Graph API. It requires a valid authentication token and the name of the driver. The function waits until the report generation is completed and then retrieves the report data.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .PARAMETER DriverName
     The name of the driver for which to create the report.

    .EXAMPLE
     New-ReportDriver -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..." -DriverName "DriverName"

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter(Mandatory)]
        [string]$DriverName,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    if($ProxyAddress){
        $CategoryID = Get-DriversDetailsIntune -DriverName $DriverName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $CategoryID = Get-DriversDetailsIntune -DriverName $DriverName -Token $Token
    }
    $body = @{
        filter = "(CatalogEntryId eq '$($CategoryID.Category)')"
        id = "DriverUpdateDeviceStatusByDriver_00000000-0000-0000-0000-000000000001"
        OrderBy = @()
        Select = @("DeviceName", "UPN", "DeviceId", "AadDeviceId", "CurrentDeviceUpdateSubstateTime", "PolicyName", "CurrentDeviceUpdateState", "CurrentDeviceUpdateSubstate", "AggregateState", "HighestPriorityAlertSubType", "LastWUScanTime")
    } | ConvertTo-Json 

    try {
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/cachedReportConfigurations" -Method Post -Headers $headers -Body $body -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri "https://graph.microsoft.com/beta/deviceManagement/reports/cachedReportConfigurations" -Method Post -Headers $headers -Body $body
        }
        # Verificar o status do relatório até que seja "completed"
        $status = ""
        do {
            Start-Sleep -Seconds 10
            if($ProxyAddress){
                $statusResponse = Get-StatusReportDriver -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
            }else{
                $statusResponse = Get-StatusReportDriver -Token $Token
            }
            $status = $statusResponse.status
        }until ($status -eq "completed")
        if($ProxyAddress){
            Start-Sleep -Seconds 3
            $Dataresponse = Get-ResultReport -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            Start-Sleep -Seconds 3
            $Dataresponse = Get-ResultReport -Token $Token
        }
        Return $Dataresponse
    }catch {
        Write-Error -Message "Error - $($_.Exception.Message)"
        Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
        Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}

Function Add-AADMemberToGroup {
    <#
    .SYNOPSIS
     Add a user or device to an Azure Active Directory (AAD) group by name.

    .DESCRIPTION
     This function adds a specified user or device to an Azure Active Directory (AAD) group using the Microsoft Graph API. It requires the member name, group name, type of member (User or Device), and a valid authentication token. The function retrieves the AAD object ID for the user or device and the group before making the addition.

    .PARAMETER MemberName
     The name of the user or device to be added to the group.

    .PARAMETER GroupName
     The name of the group to which the user or device will be added.

    .PARAMETER Type
     The type of the member to be added. Valid values are "User" and "Device".

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Add-AADMemberToGroup -MemberName "john.doe" -GroupName "FinanceGroup" -Type "User" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    .EXAMPLE
     Add-AADMemberToGroup -MemberName "Device123" -GroupName "DeviceGroup" -Type "Device" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    param (
        [Parameter(Mandatory)]
        [string]$MemberName,
        [Parameter(Mandatory)]
        [string]$GroupName,
        [Parameter(Mandatory)]
        [ValidateSet("User", "Device")]
        [string]$Type,
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        if($Type -eq "User"){
            $MemberID = Get-AADObjectID -Type User -Name $MemberName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }elseif($Type -eq "Device"){
            $MemberID = Get-AADObjectID -Type Device -Name $MemberName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        if($Type -eq "User"){
            $MemberID = Get-AADObjectID -Type User -Name $MemberName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }elseif($Type -eq "Device"){
            $MemberID = Get-AADObjectID -Type Device -Name $MemberName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    if ($Type -eq "User") {
        $body = @{
            "@odata.id" = "https://graph.microsoft.com/beta/users/$MemberID"
        } | ConvertTo-Json
    } elseif ($Type -eq "Device") {
        $body = @{
            "@odata.id" = "https://graph.microsoft.com/beta/devices/$MemberID"
        } | ConvertTo-Json
    }
    $uri = "https://graph.microsoft.com/beta/groups/$GroupID/members/`$ref"
    try {
        if($ProxyAddress){
            Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body
        }
        Write-Output "$Type $MemberName added to group successfully."
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Remove-DeviceIntune {
    <#
    .SYNOPSIS
     Remove a specified Intune-managed device by its name.

    .DESCRIPTION
     This function removes a specified device managed by Intune using the Microsoft Graph API. It requires the device name and a valid authentication token. The function retrieves the Intune device ID before making the removal request.

    .PARAMETER DeviceName
     The name of the Intune-managed device to be removed.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Remove-IntuneDevice -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="ByDeviceName")]
        [string]$DeviceName,
        [Parameter(Mandatory=$true, ParameterSetName="ByAADID")]
        [string]$AADID,
        [Parameter(Mandatory=$true)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    if($AADID){
        if($ProxyAddress){
            $IntuneID = Get-IntuneDeviceID -AADID $AADID -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue
        }else{
            $IntuneID = Get-IntuneDeviceID -AADID $AADID -Token $Token -ErrorAction SilentlyContinue
        }
    }elseif($DeviceName){
        if($ProxyAddress){
            $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue
        }else{
            $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ErrorAction SilentlyContinue
        }
    }

    if($IntuneID){
        $headers = @{
            "Authorization" = "Bearer $Token"
            "Content-Type"  = "application/json"
        }
        $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$IntuneID"
        try {
            if($ProxyAddress){
                Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential -ErrorAction SilentlyContinue | Out-Null
            }else{
                Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers -ErrorAction SilentlyContinue | Out-Null
            }
            Write-Output "Success"
        }catch{
            Write-Error "Error: $($_.Exception.Message)"
        }
    }else{
        Write-Output "Intune Devide ID not Found"
    }
} 

Function Remove-DeviceAzureAD {
    <#
    .SYNOPSIS
     Remove a specified Azure AD device by its ID.

    .DESCRIPTION
     This function removes a specified device from Azure AD using the Microsoft Graph API. It requires the device ID and a valid authentication token.

    .PARAMETER DeviceID
     The ID of the Azure AD device to be removed.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Remove-AzureADDeviceByID -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ParameterSetName="ByDeviceName")]
        [string]$DeviceName,
        [Parameter(Mandatory=$true, ParameterSetName="ByAADID")]
        [string]$AADID,
        [Parameter(Mandatory=$true)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    if($ProxyAddress){
        if($AADID){
            $DeviceID = Get-AADObjectID -AADID $AADID -Type Device -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }elseif($DeviceName){
            $DeviceID = Get-AADObjectID -Name $DeviceName -Type Device -Token $Token -ErrorAction SilentlyContinue -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }    
    }else{
        if($AADID){
            $DeviceID = Get-AADObjectID -AADID $AADID -Type Device -Token $Token
        }elseif($DeviceName){
            $DeviceID = Get-AADObjectID -Name $DeviceName -Type Device -Token $Token -ErrorAction SilentlyContinue
        }   
    }
    if($DeviceID){
        $headers = @{
            "Authorization" = "Bearer $Token"
            "Content-Type"  = "application/json"
        }
        $uri = "https://graph.microsoft.com/v1.0/devices/$DeviceID"
        try {
            if ($ProxyAddress) {
                
                Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            }else{
                    
                Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers
            }
            Write-Output "Success"
        }catch{
            Write-Error "Error: $($_.Exception.Message)"
        }
    }else{
        Write-Output "EntraID device not found - $DeviceName"
    }
} 

Function Remove-AADMemberFromGroup {
    <#
    .SYNOPSIS
     Remove a user or device from an Azure Active Directory (AAD) group by name.

    .DESCRIPTION
     This function removes a specified user or device from an Azure Active Directory (AAD) group using the Microsoft Graph API. It requires the member name, group name, type of member (User or Device), and a valid authentication token. The function retrieves the AAD object ID for the user or device and the group before making the removal.

    .PARAMETER MemberName
     The name of the user or device to be removed from the group.

    .PARAMETER GroupName
     The name of the group from which the user or device will be removed.

    .PARAMETER Type
     The type of the member to be removed. Valid values are "User" and "Device".

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Remove-AADMemberFromGroup -MemberName "john.doe" -GroupName "FinanceGroup" -Type "User" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    .EXAMPLE
     Remove-AADMemberFromGroup -MemberName "Device123" -GroupName "DeviceGroup" -Type "Device" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    param (
        [Parameter(Mandatory)]
        [string]$MemberName,
        [Parameter(Mandatory)]
        [string]$GroupName,
        [Parameter(Mandatory)]
        [ValidateSet("User", "Device")]
        [string]$Type,
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        if($Type -eq "User"){
            $MemberID = Get-AADObjectID -Type User -Name $MemberName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }elseif($Type -eq "Device"){
            $MemberID = Get-AADObjectID -Type Device -Name $MemberName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        }
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        if($Type -eq "User"){
            $MemberID = Get-AADObjectID -Type User -Name $MemberName -Token $Token
        }elseif($Type -eq "Device"){
            $MemberID = Get-AADObjectID -Type Device -Name $MemberName -Token $Token
        }
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    if ($Type -eq "User") {
        $uri = "https://graph.microsoft.com/beta/groups/$GroupID/members/$MemberID/`$ref"
    } elseif ($Type -eq "Device") {
        $uri = "https://graph.microsoft.com/beta/groups/$GroupID/members/$MemberID/`$ref"
    }
    try {
        if($ProxyAddress){
            Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            Invoke-RestMethod -Uri $uri -Method Delete -Headers $headers
        }
        Write-Output "$Type $MemberName removed from group successfully."
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Remove-AllAADMembersFromGroup {
    <#
    .SYNOPSIS
     Remove all users or devices from an Azure Active Directory (AAD) group by group name.

    .DESCRIPTION
     This function removes all specified members (users or devices) from an Azure Active Directory (AAD) group using the Microsoft Graph API. It requires the group name, type of members to remove (User or Device), and a valid authentication token. The function retrieves the AAD object ID for the group before making the removal requests.

    .PARAMETER GroupName
     The name of the group from which all specified members will be removed.

    .PARAMETER Type
     The type of members to be removed. Valid values are "User" and "Device".

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Remove-AllAADMembersFromGroup -GroupName "FinanceGroup" -Type "User" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    .EXAMPLE
     Remove-AllAADMembersFromGroup -GroupName "DeviceGroup" -Type "Device" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    param (
        [Parameter(Mandatory)]
        [string]$GroupName,
        [Parameter(Mandatory)]
        [ValidateSet("User", "Device")]
        [string]$Type,
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    if($ProxyAddress){
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $GroupID = Get-AADObjectID -Name $GroupName -Type Group -Token $Token
    }
    # Define a URI base para buscar membros do grupo
    $uri = "https://graph.microsoft.com/beta/groups/$GroupID/members"
    try {
        # Obter todos os membros do grupo
        if($ProxyAddress){
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        }
        $members = $response.value
        # Filtrar membros pelo tipo especificado
        $filteredMembers = $members | Where-Object { $_.'@odata.type' -like "*$Type*" }
        foreach ($member in $filteredMembers) {
            $memberID = $member.id
            $deleteUri = "https://graph.microsoft.com/beta/groups/$GroupID/members/$memberID/`$ref"
            if($ProxyAddress){
                Invoke-RestMethod -Uri $deleteUri -Method Delete -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential   
            }else{
                Invoke-RestMethod -Uri $deleteUri -Method Delete -Headers $headers
            }
            Write-Output "$Type $($member.displayname) removed from group successfully."
        }
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Remove-IntunePrimaryUserDevice {
    <#
    .SYNOPSIS
     Remove the primary user from a specified Intune-managed device by device name.

    .DESCRIPTION
     This function removes the primary user associated with a specified device managed by Intune using the Microsoft Graph API. It requires the device name and a valid authentication token. The function retrieves the Intune device ID before making the removal request.

    .PARAMETER DeviceName
     The name of the Intune-managed device from which to remove the primary user.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Remove-IntunePrimaryUserDevice -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    if($ProxyAddress){
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
    }
    try {
        if($ProxyAddress){
            Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices/$IntuneID/users/`$ref" -Method Delete -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices/$IntuneID/users/`$ref" -Method Delete -Headers $headers
        }
        Write-Output "User removed successfully"
    } catch {
        Write-Error -Message "Error - $($_.Exception.Message)"
        Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
        Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}

Function Start-SyncIntuneDevice {
    <#
    .SYNOPSIS
     Initiate a sync for a specified Intune-managed device by device name.

    .DESCRIPTION
     This function sends a request to the Microsoft Graph API to initiate a sync for a specified device managed by Intune. It requires the device name and a valid authentication token. The function retrieves the Intune device ID before making the sync request.

    .PARAMETER DeviceName
     The name of the Intune-managed device to be synced.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Start-SyncIntuneDevice -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )
    if($ProxyAddress){
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
    }
    if ($IntuneID) {
        $headers = @{
            "Authorization" = "Bearer $Token"
            "Content-Type"  = "application/json"
        }
        $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$IntuneID/syncDevice"
        try {
            if($ProxyAddress){
                $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
            }else{
                $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers
            }
            Write-Output "Sync initiated for device: $DeviceName"
        } catch {
            Write-Error "Error initiating sync: $($_.Exception.Message)"
        }
    } else {
        Write-Error "Device ID not found for device: $DeviceName"
    }
}

Function Start-RemediationScript {
    <#
    .SYNOPSIS
     Initiate an on-demand Proactive Remediation script on a specified Intune-managed device.

    .DESCRIPTION
     This function sends a request to the Microsoft Graph API to initiate an on-demand Proactive Remediation script on a specified device managed by Intune. It requires the device name, script policy ID, and a valid authentication token.

    .PARAMETER DeviceName
     The name of the Intune-managed device on which to run the Proactive Remediation script.

    .PARAMETER ScriptPolicyId
     The ID of the Proactive Remediation script policy to be executed.

    .PARAMETER Token
     The authentication token to access the Microsoft Graph API.

    .EXAMPLE
     Start-ProactiveRemediation -DeviceName "Laptop123" -ScriptPolicyId "abcdefg-12345-hijklmn-67890" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$ScriptName,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential
    )

    # Obter o ID do dispositivo Intune
    if($ProxyAddress){
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
        $ScriptPolicyId = Get-RemediationScriptID -ScriptName $ScriptName -Token $Token -ProxyAddress $ProxyAddress -ProxyCredential $ProxyCredential
    }else{
        $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token
        $ScriptPolicyId = Get-RemediationScriptID -ScriptName $ScriptName -Token $Token
    }
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    $body = @{
        scriptPolicyId = $ScriptPolicyId
    } | ConvertTo-Json
    # Definir a URI para iniciar o script de Proactive Remediation
    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices/$IntuneID/initiateOnDemandProactiveRemediation"
    try {
        # Fazer a requisição para iniciar o script de Proactive Remediation
        if($ProxyAddress){
            Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body -Proxy $ProxyAddress -ProxyCredential $ProxyCredential
        }else{
            Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body
        }
        Write-Output "Proactive Remediation script initiated successfully on device: $DeviceName"
    } catch {
        Write-Error "Error initiating Proactive Remediation script: $($_.Exception.Message)"
    }
}

Function Invoke-GraphRequest {
    <#
    .SYNOPSIS
     Execute a Microsoft Graph API request with specified HTTP method.

    .DESCRIPTION
     This function sends a request to the Microsoft Graph API using the specified HTTP method (GET, POST, DELETE, PATCH). It handles authentication using a provided access token and supports pagination for GET requests.

    .PARAMETER Method
     The HTTP method to use for the request. Valid values are "GET", "POST", "DELETE", and "PATCH".

    .PARAMETER URI
     The URI endpoint for the Microsoft Graph API request.

    .PARAMETER AccessToken
     The authentication token to access the Microsoft Graph API.

    .PARAMETER Body
     The body of the request, used for POST and PATCH methods.

    .EXAMPLE
     Invoke-GraphRequest -Method "GET" -URI "https://graph.microsoft.com/v1.0/users" -AccessToken "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

    .EXAMPLE
     Invoke-GraphRequest -Method "POST" -URI "https://graph.microsoft.com/v1.0/users" -AccessToken "eyJ0eXAiOiJKV1QiLCJhbGciOi..." -Body $bodyContent

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet("GET", "POST", "DELETE","PATCH")]
        [string]$Method,
        [Parameter(Mandatory)]
        [string]$URI,
        [Parameter(Mandatory)]
        [string]$Token,
        [Parameter()]
        $Body,
        [Parameter()]
        [string]$ProxyAddress,
        [Parameter()]
        [PSCredential]$ProxyCredential

    )
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }
    $QueryResults = @()
    do {
        try {
            if($ProxyAddress){
                $response = switch ($Method.ToUpper()) {
                "GET" { Invoke-RestMethod -Uri $URI -Method Get -Headers $headers -ErrorAction Stop -Proxy $ProxyAddress -ProxyCredential $ProxyCredential }
                "POST" { Invoke-RestMethod -Uri $URI -Method Post -Headers $headers -Body $Body -ErrorAction Stop -Proxy $ProxyAddress -ProxyCredential $ProxyCredential }
                "DELETE" { Invoke-RestMethod -Uri $URI -Method Delete -Headers $headers -ErrorAction Stop -Proxy $ProxyAddress -ProxyCredential $ProxyCredential }
                "PATCH" { Invoke-RestMethod -Uri $URI -Method Patch -Headers $headers -Body $Body -ErrorAction Stop -Proxy $ProxyAddress -ProxyCredential $ProxyCredential }
                default { throw "Método HTTP não suportado: $Method" }
                }
            $statusCode = 200
            }else{
                $response = switch ($Method.ToUpper()) {
                "GET" { Invoke-RestMethod -Uri $URI -Method Get -Headers $headers -ErrorAction Stop }
                "POST" { Invoke-RestMethod -Uri $URI -Method Post -Headers $headers -Body $Body -ErrorAction Stop }
                "DELETE" { Invoke-RestMethod -Uri $URI -Method Delete -Headers $headers -ErrorAction Stop }
                "PATCH" { Invoke-RestMethod -Uri $URI -Method Patch -Headers $headers -Body $Body -ErrorAction Stop }
                default { throw "Método HTTP não suportado: $Method" }
                }
            $statusCode = 200
            }
            
        } catch {
            $response = $null
            $statusCode = $_.Exception.Response.StatusCode.value__
            Write-Error -Message "Erro ao executar a requisição: $URI"
            Write-Error -Message "StatusCode: $($_.Exception.Response.StatusCode.value__)"
            Write-Error -Message "StatusDescription: $($_.Exception.Response.StatusDescription)"
            if ($statusCode -eq 429) {
                Write-Warning "Retry in 100 ms"
                Start-Sleep -Milliseconds 100
                continue
            } else {
                break
            }
        }
        if ($statusCode -eq 200) {
            if ($response -ne $null) {
                $QueryResults += $response
            }
            Write-Output "Success"
        }
        if ($statusCode -ne 429) {
            $URI = $response.'@odata.nextlink'
        }
    } until (!($URI))

    return $QueryResults
}

#########################################
#TESTAR DEPOIS DE PERMISSIONAR

Function Get-BitLockerRecoveryKey {
<#
.SYNOPSIS
 Retrieve the BitLocker Recovery Key for a specified Intune-managed device.

.DESCRIPTION
 This function queries the Microsoft Graph API to retrieve the BitLocker Recovery Key for a specified device managed by Intune. It requires the device name and a valid authentication token.

.PARAMETER DeviceName
 The name of the Intune-managed device for which to retrieve the BitLocker Recovery Key.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 Get-BitLockerRecoveryKey -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$Token
    )

    # Obter o ID do dispositivo Intune
    $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    # Definir a URI para obter a chave de recuperação do BitLocker
    $uri = "https://graph.microsoft.com/v1.0/informationProtection/bitlocker/recoveryKeys"

    try {
        # Fazer a requisição para obter a chave de recuperação do BitLocker
        $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        $recoveryKeys = $response.value

        # Retornar a chave de recuperação do BitLocker
        return $recoveryKeys | Select-Object @{Name="Key";Expression={$_.key}}
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

Function Get-BitLockerRecoveryKey {
<#
.SYNOPSIS
 Retrieve the BitLocker Recovery Key for a specified Intune-managed device.

.DESCRIPTION
 This function queries the Microsoft Graph API to retrieve the BitLocker Recovery Key for a specified device managed by Intune. It requires the device name and a valid authentication token.

.PARAMETER DeviceName
 The name of the Intune-managed device for which to retrieve the BitLocker Recovery Key.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 Get-BitLockerRecoveryKey -DeviceName "Laptop123" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$DeviceName,
        [Parameter(Mandatory)]
        [string]$Token
    )

    # Obter o ID do dispositivo Intune
    $IntuneID = Get-IntuneDeviceID -DeviceName $DeviceName -Token $Token

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    # Definir a URI para obter a chave de recuperação do BitLocker para um dispositivo específico
    $uri = "https://graph.microsoft.com/v1.0/informationProtection/bitlocker/recoveryKeys?`$filter=deviceId eq '$IntuneID'"

    try {
        # Fazer a requisição para obter a chave de recuperação do BitLocker
        $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers
        $recoveryKeys = $response.value

        if ($recoveryKeys) {
            return $recoveryKeys | Select-Object @{Name="Key";Expression={$_.key}}
        } else {
            Write-Error "Recovery key not found for device: $DeviceName"
        }
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

##############################################

Function Get-AppClientID {
<#
.SYNOPSIS
 Retrieve the Client ID (appId) of an App Registration in Azure AD by its name.

.DESCRIPTION
 This function sends a request to the Microsoft Graph API to retrieve the Client ID (appId) of an App Registration in Azure AD by its name. It requires the application name and a valid authentication token.

.PARAMETER AppName
 The name of the application whose Client ID you want to retrieve.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 Get-AppClientID -AppName "MyApp" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$AppName,
        [Parameter(Mandatory)]
        [string]$Token
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    # Definir a URI para buscar os App Registrations
    $uri = "https://graph.microsoft.com/v1.0/applications?`$filter=displayName eq '$AppName'"

    try {
        # Fazer a requisição para obter os App Registrations
        $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers

        # Filtrar o aplicativo pelo nome e obter o Client ID
        $app = $response.value | Where-Object { $_.displayName -eq $AppName }

        if ($app) {
            Write-Output $app.appId
        } else {
            Write-Error "App Registration not found: $AppName"
        }
    } catch {
        Write-Error "Error retrieving App Client ID: $($_.Exception.Message)"
    }
}

Function New-AppRegistration {
<#
.SYNOPSIS
 Create a new App Registration in Azure AD and generate a client secret.

.DESCRIPTION
 This function sends a request to the Microsoft Graph API to create a new App Registration in Azure AD and generate a client secret. It requires the application name and a valid authentication token.

.PARAMETER AppName
 The name of the application to be registered.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 New-AppRegistration -AppName "MyApp" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$AppName,
        [Parameter(Mandatory)]
        [ValidateSet("AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount","PersonalMicrosoftAccount")]
        [String]$Type,
        [Parameter(Mandatory)]
        [string]$Token
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    $body = @{
        displayName = $AppName
        signInAudience = "$Type"
    } | ConvertTo-Json

    # Definir a URI para criar o App Registration
    $uri = "https://graph.microsoft.com/v1.0/applications"

    try {
        # Fazer a requisição para criar o App Registration
        $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body
        $appId = $response.appId
        $appObjectId = $response.id

        Write-Output "App Registration created successfully: $appId"

        # Criar um segredo (client secret) para o App Registration
        $secretBody = @{
            passwordCredential = @{
                displayName = "DefaultSecret"
            }
        } | ConvertTo-Json

        $secretUri = "https://graph.microsoft.com/v1.0/applications/$appObjectId/addPassword"

        $secretResponse = Invoke-RestMethod -Uri $secretUri -Method Post -Headers $headers -Body $secretBody
        $clientSecret = $secretResponse.secretText

        Write-Output "Client Secret created successfully: $clientSecret"
    } catch {
        Write-Error "Error creating App Registration or Client Secret: $($_.Exception.Message)"
    }
}

Function Set-AppRegistrationPermission {
<#
.SYNOPSIS
 Grant permissions to an App Registration in Azure AD.

.DESCRIPTION
 This function sends a request to the Microsoft Graph API to grant permissions to an App Registration in Azure AD. It requires the application ID, permission type (delegated or application), permission name, and a valid authentication token.

.PARAMETER AppId
 The ID of the application to which permissions will be granted.

.PARAMETER PermissionType
 The type of permission to grant (delegated or application).

.PARAMETER PermissionName
 The name of the permission to grant.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 Grant-AppPermission -AppId "abcdefg-12345-hijklmn-67890" -PermissionType "delegated" -PermissionName "User.Read" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$AppName,
        [Parameter(Mandatory)]
        [ValidateSet("delegated", "application")]
        [string]$PermissionType,
        [Parameter(Mandatory)]
        [string]$PermissionName,
        [Parameter(Mandatory)]
        [string]$Token
    )
    $AppId = Get-AppClientID -AppName $AppName -Token $Token 
    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    # Obter o ID da permissão
    $uri = "https://graph.microsoft.com/v1.0/oauth2PermissionGrants"
    $body = @{
        clientId = $AppId
        consentType = "AllPrincipals"
        principalId = $null
        resourceId = (Get-AzureADServicePrincipal -Filter "displayName eq 'Microsoft Graph'").ObjectId
        scope = $PermissionName
    } | ConvertTo-Json

    try {
        # Fazer a requisição para conceder a permissão
        $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body
        Write-Output "Permission granted successfully: $PermissionName"
    } catch {
        Write-Error "Error granting permission: $($_.Exception.Message)"
    }
}

Function Get-AppRegistrationID {
<#
.SYNOPSIS
 Retrieve the ID of an App Registration in Azure AD by its name.

.DESCRIPTION
 This function sends a request to the Microsoft Graph API to retrieve the ID of an App Registration in Azure AD by its name. It requires the application name and a valid authentication token.

.PARAMETER AppName
 The name of the application whose ID you want to retrieve.

.PARAMETER Token
 The authentication token to access the Microsoft Graph API.

.EXAMPLE
 Get-AppRegistrationID -AppName "MyApp" -Token "eyJ0eXAiOiJKV1QiLCJhbGciOi..."

#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$AppName,
        [Parameter(Mandatory)]
        [string]$Token
    )

    $headers = @{
        "Authorization" = "Bearer $Token"
        "Content-Type"  = "application/json"
    }

    # Definir a URI para buscar os App Registrations
    $uri = "https://graph.microsoft.com/v1.0/applications?`$filter=displayName eq '$AppName'"

    try {
        # Fazer a requisição para obter os App Registrations
        $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers

        # Filtrar o aplicativo pelo nome e obter o ID
        $app = $response.value | Where-Object { $_.displayName -eq $AppName }

        if ($app) {
            Write-Output $app.id
        } else {
            Write-Error "App Registration not found: $AppName"
        }
    } catch {
        Write-Error "Error retrieving App Registration ID: $($_.Exception.Message)"
    }
}








