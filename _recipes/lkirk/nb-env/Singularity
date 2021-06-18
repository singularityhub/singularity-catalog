Bootstrap: docker
From: python:3.8-slim

%environment
export HOME=/opt/home

%runscript
/usr/bin/zsh ${@}

%startscript
jupyter lab --no-browser ${@}

%files
etc/zshrc.local /opt/home/.zshrc.local

%post
    set -e
    export HOME=/opt/home

    apt-get update
    apt-get install -y --no-install-recommends \
        locales \
        ca-certificates \
        curl \
        fonts-texgyre \
        less \
        libssl-dev \
        libcurl4-openssl-dev \
        libgit2-dev \
        libxml2-dev \
        jq \
        zsh

    # Fix locale
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen en_US.utf8
    /usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

    curl -Lo $HOME/.zshrc 'https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc'

    # Install Node
    # TODO: replace curl w/ wget and bash
    curl -sL https://deb.nodesource.com/setup_15.x | bash -
    # curl -sL https://deb.nodesource.com/setup_14.x | bash -
    apt-get install -y nodejs

    # Install JupyterLab
    pip install --no-cache-dir --upgrade pip setuptools
    pip install --no-cache-dir \
        jupyterlab \
        jupyterlab_vim \
        jupyterlab_theme_solarized_dark

    # Install R
    # Use Debian unstable via pinning -- new style via APT::Default-Release
    echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list
    echo 'apt::default-release "testing";' > /etc/apt/apt.conf.d/default
    echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/90local-no-recommends
    apt-get update
    apt-get install -t unstable -y --no-install-recommends \
        gcc-9-base \
        libopenblas0-pthread \
        littler \
        r-cran-littler \
        r-base \
        r-base-dev \
        r-recommended

    ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r
    ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r
    ln -s /usr/lib/R/site-library/littler/examples/installBioc.r /usr/local/bin/installBioc.r
    ln -s /usr/lib/R/site-library/littler/examples/installDeps.r /usr/local/bin/installDeps.r
    ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r
    ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r

    # Install R packages
    install.r \
        IRkernel \
        devtools

    r --eval '
    library('IRkernel')
    IRkernel::installspec()

    devtools::install_github("hadley/devtools")
    library('remotes')
    remotes::install_github("rstudio/renv")
    '

    jq '.github_sha = "'$GITHUB_SHA'"' /.singularity.d/labels.json > /.singularity.d/labels.json.tmp
    mv /.singularity.d/labels.json.tmp /.singularity.d/labels.json

    rm /etc/apt/sources.list.d/debian-unstable.list
    rm /etc/apt/apt.conf.d/default
    rm /etc/apt/apt.conf.d/90local-no-recommends
    rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    rm -rf /var/lib/apt/lists/*

    chsh -s /usr/bin/zsh
