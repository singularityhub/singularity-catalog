Bootstrap: docker
From: ubuntu:18.04

%labels
	CREATER Shengg
%post
    # Downloads the latest package lists (important).
    #apt -y install software-properties-common
    #add-apt-repository universe
    apt-get -y update
    # Runs apt-get while ensuring that there are no user prompts that would
    # cause the build process to hang.
    # python3-tk is required by matplotlib.
    #DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	apt -y install python3 
	apt install -y python3-pip
	#python3 \
	#python3-distutils \
	#python3 -m pip
        #python3-pip
    # Reduce the size of the image by deleting the package lists we downloaded,
    # which are useless now.
    #rm -rf /var/lib/apt/lists/*
    # Install Python modules.
    pip3 install setuptools
    #pip3 install numpy scipy pandas sklearn simplejson glob3 python-csv
    pip3 install numpy scipy pandas sklearn simplejson xgboost
    #apt-get install -y ruby-dev
    #apt-get gem install json
    #pip install simplejson
    pip3 install -v requests -i https://pypi.org/project/pycopy-glob/pycopy-glob3
    #pip3 install -v requests -i https://pypi.python.org/simple/pdb
    #pip3 install numpy sklearn json pdb csv

