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
		[string]$WebServerPort='',
		[string]$WebServerPackage=''
                
                
	)
       
        
       $InstallGooglechrome | out-file "C:\output.txt"
       $InstallPutty | Add-Content "C:\output.txt"
       $InstallTomcat | Add-Content "C:\output.txt"
       

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
		if($InstallGooglechrome -eq "true")
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
		
      If($InstallPutty -eq "true")
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

               If($InstallTomcat -eq "true")
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

   
 