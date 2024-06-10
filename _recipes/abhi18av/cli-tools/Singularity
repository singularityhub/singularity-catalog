#Bootstrap: docker
#From: centos

Bootstrap: shub
From: singularityhub/centos

%labels
AUTHOR abhi18av

%help
The cli-tools for day-to-day life of Data Scientist.


%runscript 
echo "cli-tools on Singularity-hub"

%post
echo " >>> Now you need to run the accompanying Singularity.ps1 powershell script"

echo "sudo pwsh ./Singularity.ps1"

echo " >>> Then you can login to the image using the following command "

echo "singularity shell --writable cli-tools.img"


echo "Don't forget to < cd /home/ > "