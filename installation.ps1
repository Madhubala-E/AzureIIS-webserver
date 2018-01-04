<# To verify the server manager status for DHCP and DNS #>
Get-WindowsFeature

<# Install DNS server role #>
Add-WindowsFeature -Name DNS -IncludeManagementTools

Get-WindowsFeature -Name *DNS*

<# Adding DNS server primary zone #>
Add-DnsServerPrimaryZone -Name madhugavs.com -zonefile madhugavs.com.DNS -DynamicUpdate NonsecureAndSecure

<# Install DHCP server role #>
Install-WindowsFeature -Name DHCP -IncludeManagementTools

Get-NetIPConfiguration

<# Adding DHCP server scope #>
Add-DhcpServerv4Scope -Name DHCPClient -StartRange 10.10.1.1 -EndRange 10.10.1.5 -SubnetMask 255.255.255.0

<# To verify the server manager status for Hyper-V #>
Get-WindowsFeature 

Get-WindowsFeature Hyper-V*

<# Adding Hyper-V tools #>
Add-WindowsFeature Hyper-V-tools 







