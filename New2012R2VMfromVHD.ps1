#Define the server name, e.g. TFSFILE01
$VMName="TESTSERVER"

#Allocated Starting Memory
$StartingMemory=2GB

#Set the base folder, on production servers, this will be something like D:\VMS\
$BaseFolderPath="C:\tfsltemp\"

#This is the download link from here: https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server-2012-r2
$ServerDownloadURL = "http://care.dlservice.microsoft.com/dl/download/0/C/2/0C2B1216-422C-4A22-8742-0D599E354F0C/vhd_server_serverstandardeval_en-us.exe"

########## Do not change below here ##############

#Set variables
$VMFolderPath=$BaseFolderPath + $VMNAME + "\"
$EXEPath = $VMFolderPath + "Server2012R2.exe"
$UnpackedVHDPath = $VMFolderPath + "expandedVHD\9200.16384.amd64fre.win8_rtm.120725-1247_server_serverstandardeval_en-us.vhd"
$DestinationVHDPath = $VMFolderPath + $VMName + ".vhd"

#Create a new folder
New-Item $VMFolderPath -ItemType directory

#Download the file from Microsoft
Invoke-WebRequest -Uri $ServerDownloadURL -OutFile $EXEPath

#Unpack the VHD
Invoke-Item $EXEPath

#Move and rename the unpacked VHD
Move-Item $UnpackedVHDPath $DestinationVHDPath

#Create a new VM, and attach the VHD
New-VM -Name $VMName -MemoryStartupBytes $StartingMemory -VHDPath $DestinationVHDPath

#Start the VM
Start-VM -Name $VMName file contents here