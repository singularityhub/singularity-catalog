Bootstrap: docker
From: ubuntu:latest

%help
echo "Usage: singularity run "


%runscript
$@


%post
apt-get update --fix-missing
apt-get --no-install-recommends -y install \
    git build-essential wget unzip ca-certificates

# squelch perl complaining about locale settings it doesn't understand
LANG=C
LANGUAGE=$LANG
LC_ALL=$LANG
export LANG LANGUAGE LC_ALL

# these are specific to scc
# create the directories in case OverlayFS support wasn't built in
for d in /scratch /share /project /projectnb /restricted /usr1 /usr2 /usr3 /usr4 /var/spool/sge;
do
  rm -rf $d
  mkdir $d
done
