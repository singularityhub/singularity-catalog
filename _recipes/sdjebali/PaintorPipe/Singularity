Bootstrap: library
From: ubuntu:20.04

%environment
    export LC_ALL=C
    export LANG=C.UTF-8

%post
    ln -fns /usr/share/zoneinfo/Europe/Paris /etc/localtime
    echo Europe/Paris > /etc/timezone
    apt-get update
    apt-get install -y python3 python3-pip curl default-jre tzdata git bedtools gcc \
    vcftools tabix bcftools r-base wget
    pip3 install --upgrade pip
    pip3 install multiprocess==0.70.14 pandas matplotlib seaborn scipy \
    svgutils numpy==1.23
    curl -s https://get.nextflow.io | bash
    mv nextflow /usr/local/bin/
    dpkg-reconfigure --frontend noninteractive tzdata
    
    # Install R packages
    R -e "install.packages(c('optparse', 'ggplot2'), repos='https://cran.rstudio.com/')"

    # Sarah's scripts
    git clone --branch v0.8 --depth 1 https://github.com/sdjebali/Scripts.git /usr/local/src/Scripts
    ln -s /usr/local/src/Scripts/* /usr/local/bin

    # Install PAINTOR 
    git clone --depth 1 https://github.com/gkichaev/PAINTOR_V3.0.git /usr/local/src/PAINTOR
    cd /usr/local/src/PAINTOR
    bash install.sh
    ln -s /usr/local/src/PAINTOR/PAINTOR /usr/local/bin/PAINTOR
    printf "#!/usr/bin/env python3\n\n" > header
    cat header /usr/local/src/PAINTOR/CANVIS/CANVIS.py | sed 's/.as_matrix()/.values/g' | sed 's/np.bool/bool/g' | sed 's/scale=/scale_x=/g' > /usr/local/bin/CANVIS.py
    chmod 775 /usr/local/bin/CANVIS.py
    cat header /usr/local/src/PAINTOR/PAINTOR_Utilities/CalcLD_1KG_VCF.py > /usr/local/bin/CalcLD_1KG_VCF.py
    chmod 775 /usr/local/bin/CalcLD_1KG_VCF.py


%runscript
    exec "$@"
    