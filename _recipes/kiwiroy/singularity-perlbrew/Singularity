BootStrap: docker
From: ubuntu:bionic

%labels
    Author kiwiroy@users-noreply.github.com
    Maintainer kiwiroy@users-noreply.github.com
    Version 1.00

%environment
    PERLBREW_CPAN_MIRROR=https://cpan.metacpan.org
    PERLBREW_SKIP_INIT=1
    perlbrew_command=/opt/perl5/perlbrew/bin/perlbrew
    export PERLBREW_CPAN_MIRROR PERLBREW_SKIP_INIT perlbrew_command
    SHELL=/bin/bash
    export SHELL

%post -c /bin/bash
    echo '****************************************************'
    echo 'Setup/Display Environment'
    echo '****************************************************'
    ## where to install (similar to HOME=/opt)
    export PERLBREW_ROOT=/opt/perl5/perlbrew
    export PERLBREW_HOME=/opt/.perlbrew
    mkdir -p "${PERLBREW_ROOT}" "${PERLBREW_HOME}"
    env | grep -i ^perl

    echo '****************************************************'
    echo 'Install dependencies / utils'
    echo '****************************************************'
    echo "dash dash/sh boolean false" | debconf-set-selections
    dpkg-reconfigure dash
    apt-get -y update && apt-get -y install curl perl patch build-essential git

    echo '****************************************************'
    echo 'Install perl'
    echo '****************************************************'
    curl -L https://install.perlbrew.pl | bash
    ${PERLBREW_ROOT}/bin/perlbrew init
    source ${PERLBREW_ROOT}/etc/bashrc
    perlbrew install-cpanm --yes
    perlbrew install-patchperl --yes

    echo '****************************************************'
    echo 'Store Environment'
    echo '****************************************************'
    echo '# Using bash as default shell' >  $SINGULARITY_ENVIRONMENT
    echo "export SHELL=$SHELL"           >> $SINGULARITY_ENVIRONMENT
    echo "export PERLBREW_HOME=$PERLBREW_HOME"    >> $SINGULARITY_ENVIRONMENT
    PERLBREW_LIB= \
    PERL5LIB= PERL_LOCAL_LIB_ROOT= perlbrew env   >> $SINGULARITY_ENVIRONMENT
    echo 'export PATH="${PERLBREW_PATH}:${PATH}"' >> $SINGULARITY_ENVIRONMENT

%apprun cpanm
    if ! test -d "${PERLBREW_HOME:-/fail}/libs" ; then
      echo "Directory '${PERLBREW_HOME:-/fail}/libs' does not exist." >&2
      echo "Consider using --bind /host/path/libs:$PERLBREW_HOME/libs" >&2
      exit
    fi
    source "${PERLBREW_ROOT:-/fail}/etc/bashrc"
    perlbrew lib create "${PERLBREW_PERL}@${PERLBREW_LIB:-singularity-perl}"
    perlbrew use "${PERLBREW_PERL}@${PERLBREW_LIB:-singularity-perl}"
    exec cpanm "${@}"

%apprun perl
    echo "Warning this is system perl ($(perl -E 'say $^V'))" >&2
    exec perl "${@}"

%apprun perlbrew
    exec perlbrew "${@}"

%runscript
    exec perlbrew "${@}"

%test
    if test "${SINGULARITY_CHECKTAGS:-}" = "bootstrap"; then
      . $SINGULARITY_ENVIRONMENT
    fi
    perlbrew version
    env | grep -i ^perl
