Bootstrap: docker
From: patroonorg/patroonrs:latest

%labels
    Version v0.0.1


#########
#%setup
#########

#Downlaod packages
%post

apt-get -ym update
ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata


apt-get -ymq install openms maven

strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

%environment

export LD_LIBRARY_PATH=$HOME/lib:$HOME/lib64:/usr/local/lib:/usr/local/lib64:/usr/lib:/usr/lib64:/lib:/lib64:$LD_LIBRARY_PATH

export IMAGE_NAME="openms"

#we are commenting out the rprofile thing
#touch ~/.Rprofile
#if ! grep "patRoon.path.OpenMS" $HOME/.Rprofile;
#then 
#cat << EOF >> ~/.Rprofile
#
#options(patRoon.path.OpenMS = "/usr/bin") #
#
#
#
#EOF
#
#
#
#fi  

  
%help
    This is a demo container used to illustrate a def file.
