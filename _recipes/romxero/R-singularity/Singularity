Bootstrap: docker
From: debian:sid-slim
#
# Clush
#
#

%labels
Author "Randall Cab White - rcwhite@stanford.edu"


%post
# Debian / Ubuntu
apt-get -ym update 
apt-get -ym install r-base r-base-dev r-base-core r-base-html

%runscript
	exec /usr/bin/R "$@"
