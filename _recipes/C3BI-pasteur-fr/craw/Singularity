Bootstrap: docker
from: ubuntu:bionic


%labels
	maintainer Bertrand Neron <bneron@pasteur.fr>
    package.name craw
    package.version latest
    package.homepage https://gitlab.pasteur.fr/bneron/craw
    package.license GPLv3
  
%post
    ####################################
    #         Installing system        #
    ####################################

    apt-get update -y
    apt-get install -y --no-install-recommends python3 python3-tk
    apt-get install -y git
    apt-get install -y python3-pip

    #################################
    #        installing craw        #
    #################################
    cd /usr/local/src
	git clone https://gitlab.pasteur.fr/bneron/craw/
	cd craw
	pip3 install .

	mkdir /craw
    mv tests /craw/

    #################################
    #        cleaning image         #
    #################################
	apt-get purge -y git
	apt-get autoremove -y
    apt-get clean -y

%test
    /usr/bin/python3 /craw/tests/run_tests.py -vv

%help
    This singularity image contains the Counter RNAseq Window (CRAW) package.
    Two commands are available \"coverage\" and \"htmp\.
    To run command:
         ./craw.img [coverage|htmp] [options]... [args]... .

    To get help about each command ./craw.img [coverage|htmp] --help.
    The detailed documentation is accessible here: http://bneron.pages.pasteur.fr/craw/

%runscript

# the following syntax allow to get the command and args
# in POSIX manner so compliant with dash which
# is the debian/ubuntu /bin/sh shell

CMD="$1"
shift
ARGS=${@}

case ${CMD} in
	coverage )
		exec /usr/local/bin/craw_coverage ${ARGS} ;;
	htmp )
		exec /usr/local/bin/craw_htmp ${ARGS} ;;
	* )
		echo "command \"${CMD}\" is not supported. available commands: \"coverage\"|\"htmp\"" 
    exit 127
    ;;
esac
