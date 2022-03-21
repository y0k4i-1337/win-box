# Boxstarter setup script
 
# Notes:
#  - This file has to be idempotent. it will be run several times if the
#    computer needs to be restarted. When that happens, Boxstarter schedules
#    this script to run again with an auto-logon. Fortunately choco install
#    handles trying to install the same package more than once.
#  - Pass -y to choco install to avoid interactive prompts
 
 
# Fix Windows Explorer
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
 
# Useful apps
choco install -y googlechrome
choco install -y firefox
choco install -y 7zip
choco install -y notepadplusplus
choco install git -y -params '"/GitAndUnixToolsOnPath /NoAutoCrlf"'
 
# Install Chrome extensions via Windows Registry
REG add HKEY_LOCAL_MACHINE\Software\Wow6432Node\Google\Chrome\Extensions /f
## Endpoint verification
REG add HKEY_LOCAL_MACHINE\Software\Wow6432Node\Google\Chrome\Extensions\callobklhcbilhphinckomhgkigmfocg /f
REG add HKEY_LOCAL_MACHINE\Software\Wow6432Node\Google\Chrome\Extensions\callobklhcbilhphinckomhgkigmfocg /v update_url /d https://clients2.google.com/service/update2/crx /f

# Install PowerShell Modules
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name MSOnline -Confirm:$false
Install-Module -Name AzureAD -Confirm:$false
