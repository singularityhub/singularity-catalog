Bootstrap: docker
From: artifacts/base:1.5.4

%runscript

  echo "Nothing to do here"

%post
 
   echo "Here we are installing software and other dependencies for the container!"
   mkdir /gobyweb
   cp ${HOME}/.bashrc /gobyweb
   mkdir -p /scratchLocal/gobyweb2
   mkdir -p /scratchLocal/gobyweb2/ARTIFACT_REPOSITORY-dev	
   mkdir -p /athena/campagnelab/store/data/gobyweb/dev/FILESET_AREA
   mkdir -p /athena/campagnelab/scratch/data/gobyweb/dev/GOBYWEB_SGE_JOBS	
   #libs needed by the R package Cairo
   yum install -y libXt-devel giflib-devel libjpeg-turbo-devel
   yum install -y cairo cairo-devel cairomm-devel pango pango-devel pangomm pangomm-devel
   yum clean all		
   rm -fr /etc/mail
   mkdir -p /home/gobyweb/mail

%test

  if [ ! -d /scratchLocal/gobyweb2 ]; then
	echo "%post did not run correctly"
	exit 127
  fi
  if [ ! -d /scratchLocal/gobyweb2/ARTIFACT_REPOSITORY-dev ]; then
        echo "%post did not run correctly"
        exit 127
  fi
