<# Install Chocolatey  #>
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
refreshenv
 
<# Install IIS Server #>
Install-WindowsFeature -Name web-server -IncludeManagementTools
Install-WindowsFeature -Name Web-Asp-Net45
 
<# Configure the IIS server #>
Set-WebBinding -Name 'Default Web Site' -BindingInformation "*:80:" -PropertyName Port -Value 8080
netsh advfirewall firewall add rule name="HTTP Web Application" dir=in action=allow protocol=TCP localport=8080
 
Start-Process -FilePath "C:\Windows\System32\calc.exe"
 
<# Google Chrome Browser #>
choco install googlechrome
 
<# VC++ runtimes needed as dependencies for other installations #>
choco install vcredist-all -y
 
<# Altering the time zone of the machine #>
cd $env:WINDIR\system32\
tzutil /s 'India Standard Time'