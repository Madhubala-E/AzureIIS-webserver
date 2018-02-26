<# Installing additional Components like
	IIS,Tomcat, Websphere, MySQL softwares and
	Google Chrome browser, Putty, 7Zip, Tomcat utilities
	in Azure windows based vm images #>


 #Import environment variables #
 param
	(
		#[bool]$InstallIIS=1,
		[string]$InstallTomcat,
		[string]$InstallWebSphere,
		[string]$InstallMySQL,
		[string]$InstallGooglechrome,
		[string]$InstallPutty,
		[string]$WebServerPort='',
		[string]$WebServerPackage=''
                #[bool]$Install7Zip=0
	)
       
        
       $InstallGooglechrome | out-file "C:\output.txt"
       $InstallPutty | Add-Content "C:\output.txt"
       $InstallTomcat | Add-Content "C:\output.txt"
       $InstallWebSphere | Add-Content "C:\output.txt"
       $InstallMySQL | Add-Content "C:\output.txt"
       

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

	try {
		# SQL Server Management Studio #
		choco install sql-server-management-studio -y
	}
	catch
	{
		Write-Output "Unable to install SQL Server management Studio"
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