Bootstrap: docker
From: adamwilsonlab/emma:latest

%labels
  Author Adam M. Wilson
  Version 0.0.1

%apprun rserver
    exec rserver "${@}"

%runscript
    exec rserver "${@}"

%startscript
    echo "Container was created $NOW"
    echo "RUNNING rserver startscript"
    echo "Arguments received: $*"
    echo user = $USER      password = $PASSWORD     port = $PORT
    rserver  "$@"

%post

  # Save date - not sure if this is needed
        NOW=`date`
        echo "export NOW=\"${NOW}\"" >> $SINGULARITY_ENVIRONMENT

        # Add a default CRAN mirror
        mkdir -p /usr/lib/R/etc/
        echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/lib/R/etc/Rprofile.site

        # Add a directory for host R libraries
        mkdir -p /library
        echo "R_LIBS_SITE=/library:\${R_LIBS_SITE}" >> /usr/lib/R/etc/Renviron.site
