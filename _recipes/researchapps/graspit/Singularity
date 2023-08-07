Bootstrap: docker
From: ubuntu:14.04

%runscript
    echo "SINGULARITY RUNSCRIPT"
    echo "Arguments received: $*"
    exec /opt/anaconda3/bin/python "$@"


%post
    apt-get update && apt-get install -y git
    git clone http://www.github.com/researchapps/graspit.git
    cd graspit
    chmod u+x post.sh
    bash post.sh
