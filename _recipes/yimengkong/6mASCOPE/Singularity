Bootstrap: docker
From: centos:centos8

%help
For more information about 6mASCOPE, please consult https://github.com/yimengkong/6mASCOPE

# Add files to the container
%setup


    
# Install dependencies
%post
    # Install basic dependencies
    dnf check-update && dnf upgrade -y

    dnf install -y \
        "glibc-locale-source" \
        "glibc-langpack-en" \
        "wget" \
        "bzip2" \
        "make" \
        "perl" \
        "git" \
	    "which"


        
    # Include 6mASCOPE toolbox
    mkdir /sc
    mkdir /home/6mASCOPE
    
    #clone 6mASCOPE code
    #git clone https://github.com/yimengkong/6Scode.git /home/6mASCOPE/
	cd /home/6mASCOPE/
	git init
	git remote add -f origin https://github.com/yimengkong/6mASCOPE.git
	git config core.sparseCheckout true
	echo "code" >> .git/info/sparse-checkout
	echo "database" >> .git/info/sparse-checkout
	git pull origin master
	rm -rf .git
		    

    # Install remaining dependencies
    
    bash /home/6mASCOPE/code/postInstall

    # Define working directory
    cd /home/6mASCOPE
    

    # Set default behavior
    cat > /.singularity.d/env/99-custom.sh <<EOF
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]6mASCOPE:\[\033[33;1m\]\w\[\033[m\]\n$ "
SINGULARITY_SHELL=/bin/bash
EOF

%environment
    export HOME=/home/6mASCOPE

%runscript
    cd /home/6mASCOPE
    exec /bin/bash

%labels
    Version v1.0.0

