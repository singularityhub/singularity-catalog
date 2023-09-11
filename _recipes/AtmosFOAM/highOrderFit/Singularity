Bootstrap:docker
From:ubuntu:$VERSION

%post
	apt update -qq
	apt install wget software-properties-common apt-transport-https -y --no-install-recommends
	sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
	add-apt-repository "http://dl.openfoam.org/ubuntu dev" -y
	add-apt-repository "http://atmosfoam-apt.s3-website-eu-west-1.amazonaws.com dev" -y
	apt -qq update --allow-insecure-repositories

	DEBIAN_FRONTEND=noninteractive \
	apt install devscripts debhelper libdistro-info-perl -y
	apt install atmosfoam openfoam-dev -y --allow-unauthenticated --no-install-recommends

