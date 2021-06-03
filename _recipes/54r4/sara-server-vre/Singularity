Bootstrap: docker
From: ubuntu:16.04

%post
apt-get update && apt-get -y install git wget vim openjdk-8-jdk gtk3-engines-xfce python python-pycurl xterm
mkdir -p /opt
cd /tmp
#wget http://www.uni-ulm.de/~nsn25/SARA/eclipse-jee-oxygen-1-linux-gtk-x86_64.tar.gz
wget http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/oxygen/1a/eclipse-jee-oxygen-1a-linux-gtk-x86_64.tar.gz -O e.tgz
sha256sum e.tgz # c2435e8f52fbe94859e8786d3c631c3c3b592c5f58d4c49de615fc414f6dfe3c
tar -xzf e.tgz
mv /tmp/eclipse /opt
mkdir -p /lib/modules # required for udocker to run 
wget https://raw.githubusercontent.com/indigo-dc/udocker/v1.1.1/udocker.py -O /usr/bin/udocker
chmod +x /usr/bin/udocker
udocker --allow-root mkrepo /udocker
udocker --allow-root --repo=/udocker pull c1t4r/sara-server-vre
rmdir /udocker/containers
ln -s /tmp/udocker_containers /udocker/containers

%environment
export PATH="/opt/eclipse:$PATH"

%runscript
if [ "_$1" = _ ]; then
	BASE=/tmp/sara
else
	BASE="$1"
	shift
fi

if [ "$#" -eq 0 ]; then
	GITDIR="$BASE/sara-server"
        if [ -z "${GIT_ARCHIVE_URL}" ]; then 
                GIT_ARCHIVE_URL="git@git.uni-konstanz.de:sara/SARA-server.git"
        fi

	if ! [ -d "$GITDIR" ]; then
		echo "checking out to $GITDIR..."
		mkdir -p "$GITDIR"
		git clone "$GIT_ARCHIVE_URL" "$GITDIR"
		cd "$GITDIR"
		git submodule update --init
	else
		echo "updating $GITDIR..."
		cd "$GITDIR"
		git pull
		git submodule update
	fi
else
	GITDIR="$1"
	echo "using existing working copy in $GITDIR"
	# IMO we shouldn't pull it here
	# the user "owns" that directory, so we better not mess with it
	/bin/echo -e '\e[1;33mplease "git pull" it manually if necessary!\e[0m'
	cd "$GITDIR"
fi

/bin/echo -e '\e[32m' # sometimes, dash sucks!
echo "===================================================="
/bin/echo -en '\e[1m'
echo "IF THIS IS YOUR INITAL RUN, PLEASE DO THE FOLLOWING:"
/bin/echo -e '\e[0;32m'
echo " 1) Import the SARA code as 'Existing Maven Project'"
echo " 2) Open 'bwfdm.sara.Application' and right-click 'Run' -> 'Java Application'"
echo " 3) Wait for Spring to start, connect to 'http://localhost:8080'"
echo " 4) Congrats ... you're done!"
/bin/echo -e '\e[0m'

echo "calling eclipse"
/opt/eclipse/eclipse -configuration "$BASE/eclipseconfig" -data "$BASE"
echo "Exiting Container..."
sync
