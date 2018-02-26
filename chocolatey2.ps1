<# Installing additional Components like
	IIS,Tomcat, Websphere, MySQL softwares and
	Google Chrome browser, Putty, 7Zip, Tomcat utilities
	in Azure windows based vm images #>


 #Import environment variables #
 param
	(
                [string]$InstallGooglechrome,
                [string]$InstallPutty,
		[string]$InstallTomcat,
                [string]$InstallMySQL,
		[string]$InstallWebSphere,
		[string]$WebServerPort='',
		[string]$WebServerPackage='',
                [string]$Install7Zip,
                [string]$InstallIIS
                
	)
       
        
       $InstallGooglechrome | out-file "C:\output.txt"
       $InstallPutty | Add-Content "C:\output.txt"
       $InstallTomcat | Add-Content "C:\output.txt"
       $InstallWebSphere | Add-Content "C:\output.txt"
       $InstallMySQL | Add-Content "C:\output.txt"
       $InstallIIS | Add-Content "C:\output.txt"
       

	try {
	# Altering the time zone of the machine #
		cd $env:WINDIR\system32\
		tzutil /s 'India Standard Time'
	}
	catch
	{
		Write-Output "Unable to set the time zone"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

	try {
		<# Install Chocolatey  #>
		iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
		refreshenv
	}
	catch
	{
		Write-Output "Unable to install the Chocolatey"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

          Start-Sleep -s 5
		
	choco feature enable -n allowGlobalConfirmation


	try {
		if($InstallGooglechrome -eq "yes")
		{
			<# Google Chrome Browser #>
			choco install googlechrome -y
		}
	}
	catch
	{
		Write-Output "Unable to install Google Chrome browser"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

          Start-Sleep -s 10

	try {
		
      If($InstallPutty -eq "yes")
		{
			<# Putty application #>
			choco install putty.install -y
		}
	}
	catch
	{
		Write-Output "Unable to install Putty application"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

         Start-Sleep -s 5



           try {

               If($InstallTomcat -eq "yes")
               {
                    <# Tomcat application #>
                     choco install tomcat -y
                    
               }

             }
       
        catch 
        {
                 
		Write-Output "Unable to install tomcat"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage

          }

   
  Start-Sleep -s 5


	try {
		
    If($InstallMySQL -eq "yes")
		{
			<# 7zip application #>
			choco install 7zip -y

			<# MySQL #>
			choco install mysql -y
		}
	}
	catch
	{
		Write-Output "Unable to install MySQL server"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}


  Start-Sleep -s 5
   

try {

 If($InstallIIS -eq "yes")
 {
		<# Install IIS Server #>
		Install-WindowsFeature -Name web-server -IncludeManagementTools
		Install-WindowsFeature -Name Web-Asp-Net45

		<# Configure the IIS server #>
		Set-WebBinding -Name 'Default Web Site' -BindingInformation "*:80:" -PropertyName Port -Value 8080
		netsh advfirewall firewall add rule name="HTTP Web Application" dir=in action=allow protocol=TCP localport=8080
	}
 }
	catch
	{
		Write-Output "Unable to install IIS Server"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}


  Start-Sleep -s 5   

try {

  If($InstallSQLStudio -eq "yes")
{
		# SQL Server Management Studio #
		choco install sql-server-management-studio -y
	}
}
	catch
	{
		Write-Output "Unable to install SQL Server management Studio"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}
