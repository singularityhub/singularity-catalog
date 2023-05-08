Bootstrap:docker
From:ubuntu:$VERSION

%post
	apt-get update -qq
	apt-get install wget software-properties-common apt-transport-https -y --no-install-recommends
	sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
	add-apt-repository "http://dl.openfoam.org/ubuntu dev" -y
	apt-get -qq update

	DEBIAN_FRONTEND=noninteractive \
	apt-get install devscripts debhelper openfoam-dev -y
