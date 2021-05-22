Bootstrap: docker
From: openfoamplus/of_v2012_centos73:release

%setup
    # Nothing to be done here.

%files
    # best practices: "Files should always be owned by a system account (UID less than 500)"

    # Texlive installation profile:
    # You can generate your own by getting the Texlive `install-tl` script
    # as detailed below in %post, running it without arguments to get the
    # interactive mode, make your changes (I selected the installation scheme
    # "scheme-basic"), then choose the option to just save the profile to `texlive.profile`.
    # IMPORTANT: Don't forget to edit the file to make the paths match the
    # expectations in %post below, and to make them work with Singularity!
    singularity_texlive.profile /texlive.profile

%environment
    # source /opt/openfoam/setEnv.sh
    PYENV_ROOT=/opt/pyenv
    PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

%post
    # IMPORTANT: Avoid chaining commands with `&&` as this may cause %post to fail silently!
    #  See https://github.com/sylabs/singularity/issues/1597
    # Alternatively, surround them with parentheses:
    #  https://github.com/singularityhub/singularity-cli/issues/103#issuecomment-496312915

    # We'll use Pyenv as Python releases in CentOS appear to lag behind.
    # Using this tutorial: https://www.tecmint.com/pyenv-install-and-manage-multiple-python-versions-in-linux/
    # Using this Github Gist: https://gist.github.com/jprjr/7667947
    # Also see "Suggested build environment" here: https://github.com/pyenv/pyenv/wiki

    # Ensure this file exists, because Texlive installation tends to fail often
    # for various reasons, one being that this file is not readable:
    cat /texlive.profile

    # Pyenv requirements:
    yum install -y epel-release
    yum install -y \
        git \
        gcc \
        zlib-devel \
        bzip2-devel \
        readline-devel \
        sqlite-devel \
        openssl-devel \
        tk-devel \
        xz-devel \
        libffi-devel

    # For Snakemake for Python 3.8 we currently need libdatrie-devel
    #  because Snakemake depends on datrie, which currently doesn't officially support Python 3.8.
    #  See also this long-open pull request: https://github.com/pytries/datrie/pull/76
    #  Or this related Snakemake issue: https://github.com/snakemake/snakemake/issues/246
    # libdatrie requirements:
    yum install -y \
        libtool \
        autoconf-archive
    # We need to build libdatrie ourselves as it isn't available in CentOS 7…
    # No helpful readme with build instructions, so copying from Arch:
    #  https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/libdatrie
    git clone https://github.com/tlwg/libdatrie.git /opt/libdatrie
    cd /opt/libdatrie
    ./autogen.sh
    ./configure --prefix=/usr --disable-static
    make
    make install
    # Add /usr/lib to $LD_LIBRARY_PATH so libdatrie.so.1 can be found after installation
    # (https://stackoverflow.com/questions/1099981/why-cant-python-find-shared-objects-that-are-in-directories-in-sys-path/1100016#1100016):
    echo "export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH" >> $SINGULARITY_ENVIRONMENT

    yum install -y vim
    # For Snakemake visualizations:
    yum install -y graphviz-devel

    git clone https://github.com/pyenv/pyenv.git /opt/pyenv

    export PYENV_ROOT=/opt/pyenv
    export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
    # Cflags for python compilation with pyenv (see their wiki):
    export CFLAGS="-O2"

    pyenv install 3.9.3
    pyenv global 3.9.3
    pyenv rehash
    python3 --version
    python3 -m ensurepip --upgrade
    pip3 install pipenv numpy scipy pandas

    # OpenFoam's setEnv.sh script assumes /etc/bashrc to exist, so create it:
    touch /etc/bashrc
    echo 'source /opt/openfoam/setEnv.sh' >> $SINGULARITY_ENVIRONMENT

    # Install Texlive
    # Based on https://github.com/zimmerst/centos-texlive/blob/master/Dockerfile
    yum -y install perl-Digest-MD5 wget poppler-utils
    curl -o /tmp/install-tl-unx.tar.gz ftp://ftp.fu-berlin.de/tex/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz
    cd /tmp/
    tar xzf install-tl-unx.tar.gz
    rm install-tl-unx.tar.gz
    bash -c "cd /tmp/install-tl-* && ./install-tl -profile /texlive.profile -no-verify-downloads -persistent-downloads"

    echo 'export PATH=/usr/local/texlive/bin/x86_64-linux:$PATH' >> $SINGULARITY_ENVIRONMENT
    echo 'export MANPATH=/usr/local/texlive/texmf-dist/doc/man:$MANPATH' >> $SINGULARITY_ENVIRONMENT
    echo 'export INFOPATH=/usr/local/texlive/texmf-dist/doc/info:$INFOPATH' >> $SINGULARITY_ENVIRONMENT

    export PATH=/usr/local/texlive/bin/x86_64-linux:$PATH
    # Install individual additional packages (saves a lot of diskspace compared to using the next 'level' of `install-tl`):
    tlmgr install csquotes
    tlmgr install ucs  # for utf8x.def, expected by Matplotlib
    tlmgr install type1cm cm-super dvipng  # sometimes expected by Matplotlib
    tlmgr install pgf xcolor

    # The following is required for Qt applications such as ParaView
    # to accept keyboard inputs.
    # You may have to run the container with
    # `singularity shell -B /usr/share/X11/xkb cases.simg`.
    # For details, see https://sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html
    echo 'export QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb:$QT_XKB_CONFIG_ROOT' >> $SINGULARITY_ENVIRONMENT

    # Cleanup
    yum clean all
    rm -rf /var/cache/yum

%runscript
    # Executed if container is run as a binary.
    # echo "Arguments received: $*"
    # exec echo "$@"
    if [ $# -ne 0 ]; then
        exec "$@"
    else
        # Use bash to execute `pipenv shell`.
        # We can't run `pipenv shell` directly as we want to specify /bin/bash as shell,
        # and fish, for example, has a different syntax for doing so.
        # `--fancy` is necessary for `pipenv shell` to forward `--norc` etc. to bash
        #  (see https://github.com/pypa/pipenv/issues/2910#issuecomment-426484374):
        exec bash --norc --noprofile
    fi

%startscript
    # Executed if started like so:
    #  singularity instance start cases.sif my-cases-instance
    echo "Startscript"

%test

%labels
    Author ccs-labs.org
    Version v0.0.1

%help
    This container can be used for running OpenFOAM fluid simulations for the Pogona macroscopic molecular communication simulator.

    Open a shell for example like so: `./cases.simg /bin/bash`.

    To run a simulation, call this container with "cd /mamoko-openfoam-cases/<case dir> && ./AllRun"
