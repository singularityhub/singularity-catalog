Bootstrap:docker 
From:python:3

%post
	pip install imageio
	pip install imageio-ffmpeg


Bootstrap: docker
From: bethgelab/deeplearning:cuda9.0-cudnn7

%post
	add-apt-repository ppa:deadsnakes/ppa
	add-apt-repository --remove ppa:jonathonf/python-3.6
	apt-get update
	apt-get -y install ffmpeg
	apt-get -y install nano
	apt-get clean
	apt-get autoclean

	pip3 install tensorflow-gpu==1.8
	pip3 install --upgrade pip 
	pip3 install ruamel_yaml
	pip3 install deeplabcutcore
	pip3 install ipywidgets
	pip3 install seaborn
  
