#Create a directory and provide a path
md "c:\gcare"
$out_file="c:\GCare\agentinstall.zip"
$dest_path="c:\GCare\"
$install_path= "c:\GCare\GCareAgent.msi"

#Download GCare Agent 
Invoke-WebRequest https://github.com/Madhubala-E/AzureIIS-webserver/raw/master/gcare-agent.zip -OutFile $out_file

#Extract and copy the files in GCareagent
Expand-Archive $out_file -DestinationPath  $dest_path
#Start the msi installation
msiexec /i $install_path /qn /log "C:\agentinstall\gcareinstall.log"
#Start-Process $install_path -ArgumentList '/quiet' -Wait /log $dest_path+"\gcareinstall.log"
