Bootstrap: shub
From: singularityhub/ubuntu

%runscript
	exec jupyter lab
	
%post
	apt-get update && apt-get -y install python3 git wget bzip2
	wget https://repo.continuum.io/miniconda/Miniconda3-4.5.1-Linux-x86_64.sh
	
	bash Miniconda3-4.5.1-Linux-x86_64.sh -b -p ./miniconda
	export PATH=miniconda/bin:$PATH
	conda install jupyter
	
	

