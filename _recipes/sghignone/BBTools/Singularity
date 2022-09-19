Bootstrap: docker
From: anapsix/alpine-java:latest


%labels
	author Stefano Ghignone
	maintainer sghignone
	name BBTools
	version v38.90 (released 2021-02-03) 
	bbmap 38.90
%post
	apk update && apk upgrade \
	&& apk add --no-cache sudo build-base wget

	#download and unpack bbtools from Sourgeforge
	wget -c https://downloads.sourceforge.net/project/bbmap/BBMap_38.90.tar.gz -P /opt/
	tar -xvzf /opt/BBMap_38.90.tar.gz -C /opt/
	rm /opt/BBMap_38.90.tar.gz

%environment
	export PATH=/opt/bbmap:$PATH
