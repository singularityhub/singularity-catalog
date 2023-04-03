Bootstrap: docker
From: docker://centos:7

%labels
	AUTHOR Ben Shealy <btsheal@clemson.edu>

%post
	# install package dependencies
	yum install -q -y wget

	# download iRODS icommands rpm
	wget https://files.renci.org/pub/irods/releases/4.1.12/centos7/irods-icommands-4.1.12-centos7-x86_64.rpm

	# install iRODS icommands
	yum install -q -y irods-icommands-4.1.12-centos7-x86_64.rpm

	# cleanup
	rm -f irods-icommands-4.1.12-centos7-x86_64.rpm
