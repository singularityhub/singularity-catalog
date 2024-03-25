
# Singularity container definition 
# contain performance tools
# and number of sys admin tools, maybe trivial but not avail on a cluster node
# https://github.com/tin6150/perf_tools
# https://singularity-hub.org/collections/377
# singularity pull shub://tin6150/perf_tools
# ./tin6150-perf_tools-master-latest.simg 
# to get zsh from inside the container and interactively run the available tools
# singularity 2.6 image are executable by singularity 3.2


BootStrap: docker
#From: centos:7.6.1810
From: centos:7
#From: centos:6
#From: cern:slc6-base
#From: ringo:scientific:6.5

%help
	This container is a CentOS 7 with a number of sys admin tools for performance troubleshooting use,
	especially for smal stateless VNFS image of an hpc node.
	It defaults to a zsh inside the container and have things like iperf3, sysstat, stress, p7zip, etc.
	download: singularity pull shub://tin6150/perf_tools
	ref 1: https://github.com/tin6150/perf_tools
	ref 2: https://singularity-hub.org/collections/377

%runscript
	echo "zsh from inside the container..."
	/bin/zsh


%post
	#echo "Hello from inside the container"
	touch /THIS_IS_INSIDE_SINGULARITY
	yum -ty update 
	yum -ty install vim bash zsh wget curl tar coreutils which util-linux-ng man \
			environment-modules \
			ipmitool \
			pciutils \
			smartmontools \
			epel-release  # sl6 may need diff mech to enable epel
			#libpng libpng-devel libpng-static \
			#openmotif openmotif-devl openmotif22 \
			# smartmontools provides smartctl to check hd status



	# performance tools, many are from epel
	yum -ty install \
			iperf3 iperf3 perf sysstat \
			ethtool iftop telnet \
			nmap nuttcp iptraf iptraf-ng \
			htop ntop \
			powertop \
			strace \
			stress stress-ng p7zip p7zip-doc sysbench \
			openssh-clients numactl torque-libs opensm-libs librdmacm \
			spectre-meltdown-checker \
			kernel-tools 
			#openssh-clients numactl libtorque opensm-libs  are needed by Y's staging test

			# powertop     # does not always work
			# systsat includes: sar iostat mpstat 
			# net-tools: mii-tool  
			# iputils: tracepath \

  # https://snapcraft.io/install/icdiff/rhel
	# install icdiff via snap, avail from rhel 7.6 onward
	# but snap overlay fs may not work inside singularity
	#rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  #yum --enablerepo=


  # adding some difftool, see psg/linux.html#difftools 
	# wdiff is gnu word diff
	# meld is gui tool
	yum -ty install \
			colordiff \
			wdiff \
			meld \
			smem \
			python36-pip python-pip

	#which pip  # this throws an error and abort singularity hub build.  where was 
	#pip --help
	#pip install --quiet --no-color icdiff || echo "no pip found"
	pip install --quiet icdiff || echo "some pip error" 

	echo "end"                  >> /THIS_IS_INSIDE_SINGULARITY
	date                        >> /THIS_IS_INSIDE_SINGULARITY

%labels
MAINTAINER  Tin Ho tin'at'lbl.gov


# vim: noexpandtab tabstop=4 paste
