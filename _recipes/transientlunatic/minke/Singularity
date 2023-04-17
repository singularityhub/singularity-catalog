BootStrap: docker
From: lpmn/lalsuite:minke-latest

%post
	git config --global user.name "Anonymous" 
	git config --global user.email anonymous@example.com

	git clone https://github.com/transientlunatic/minke.git 
 	cd minke 
	python setup.py install 