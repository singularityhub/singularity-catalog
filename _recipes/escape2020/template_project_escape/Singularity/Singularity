Bootstrap: docker
From: ubuntu:latest

%files
        environment.yml

%environment
        export LC_ALL=C

%post
        apt-get -y update
        apt-get -y install git
        apt-get -y install wget
        apt-get clean
        apt-get autoremove

        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
        bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
        rm Miniconda3-latest-Linux-x86_64.sh

        . /opt/conda/etc/profile.d/conda.sh
        conda env create -f environment.yml
        conda activate escape_template

        git clone https://gitlab.in2p3.fr/escape2020/wp3/template_project_escape.git
        cd template_project_escape
        git fetch --tags
        tag=$(git describe --tags `git rev-list --tags --max-count=1`)
        if [ -z "$tag" ]; then
            git pull origin master
        else
            git checkout $tag -b master_tag_$tag
        fi
        python setup.py install

        conda clean -a

%runscript
        . /opt/conda/etc/profile.d/conda.sh; conda activate escape_template; square_number -i $1

%help
        This is a template container used to illustrate a simple singularity recipe.

        Starting from an Ubuntu (latest version) container:
         - It downloads and install miniconda3, git and wget.
         - It clones and install a git repository.

         To run the image :
         >> singularity run escape_tempalte.simg -7