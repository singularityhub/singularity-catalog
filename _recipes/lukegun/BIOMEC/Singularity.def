BootStrap: debootstrap
OSVersion: bionic
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%setup
    mkdir -p ${SINGULARITY_ROOTFS}/runcode  
	cp -R BIOMEC/Analysiscode/. ${SINGULARITY_ROOTFS}/runcode/
	cp BIOMEC/mecsim.cpython-37m-x86_64-linux-gnu.so ${SINGULARITY_ROOTFS}/runcode/mecsim.cpython-37m-x86_64-linux-gnu.so

%files
    

%runscript
    
	# var 1 = Input file
    if [ $# -ne 1 ];
	then
       echo "Please provide an Input file."
       exit 1
    fi
	
	echo "running"
	python3.7 ${SINGULARITY_ROOTFS}/runcode/PINTS_MECsim.py $1
    
	echo "finished"
    

%labels 
    AUTHOR Luke Gundry
	MECSim Aurthor: Gareth Kennedy
	
	Currenly set up to run on python 3.7 in unbuntu bionic working in a singulrity Version 3.1 container hough higher should work

%post
    
	# install packages and python modules
    apt-get -y --force-yes install vim
    apt-get -y --force-yes update
    apt-get -y --force-yes install build-essential git
    apt-get -y --force-yes install gfortran
    apt-get -y --force-yes install python3.7
    apt-get -y --force-yes install software-properties-common
	apt-get -y --force-yes install bc
    apt-add-repository  universe
    apt-get update
    apt-get -y --force-yes install python3-pip python3.7-dev
    python3.7 -m pip install --upgrade pip
    python3.7 -m pip install pandas numpy scipy cma seaborn matplotlib
	python3.7 -m pip install pints
	
	# change permissions of files
    chmod -R 777 ${SINGULARITY_ROOTFS}/runcode
