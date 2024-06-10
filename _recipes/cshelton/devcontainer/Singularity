BootStrap: docker
From: fedora:28

%post
	dnf -y update
	dnf -y install gcc gdb make gcc-c++ cgdb
	dnf -y install vim git patch diffstat
	dnf -y install boost-devel
	dnf -y install valgrind
	dnf -y install man-pages
