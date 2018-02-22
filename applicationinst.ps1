 
Configuration CloudifyExample
{
 param
	(

		[int]$InstallGooglechrome,
		[int]$InstallPutty,

	)


$InstallGoogleChrome | out-file "C:\output.txt"
       $Putty | Add-Content "C:\output.txt" 
  
  try {
	<# Altering the time zone of the machine #>
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

	<#try {
		# VC++ runtimes needed as dependencies for other installations
		choco install vcredist-all -y
	
	catch
	{
		Write-Output "Unable to install VC++ redistributables"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}#>

	
	choco feature enable -n allowGlobalConfirmation


	try {
		if($InstallGoogleChrome -eq 1)
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

	try {
		If($InstallPutty -eq 1)
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
}   
        