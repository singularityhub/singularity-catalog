Bootstrap: docker
From: centos:7

%files
	./scif_app_recipes/ /opt/

%post
	echo "Install basic development tools"
	yum -y groupinstall "Development Tools"
	yum -y update && yum -y install wget curl

	echo "Install python2.7 setuptools and pip"
	yum -y install python-setuptools
	easy_install pip

	echo "Installing SCI-F"
	pip install scif

	echo "Installing R app"
	scif install /opt/scif_app_recipes/pikavirus_v1.0_centos7.scif

	find /scif/apps -maxdepth 2 -name "bin" | while read in; do echo "export PATH=\${PATH}:$in" >> $SINGULARITY_ENVIRONMENT;done

%runscript
    exec scif "$@"
