Bootstrap: docker
From: ubuntu

%labels
    author Jennifer Chang
    title Cavatica: A pipeline for identifying author adoption trends among software or methods
    doi 10.1109/BIBM.2017.8217990
    last-update 2018-07-26
%post
    apt-get -y update
    apt-get install -y git
    git clone https://github.com/TeamMango/cavatica.git
    chmod -R go+rw /cavatica/ 
    DEBIAN_FRONTEND=noninteractive apt-get install -y r-base 
    echo "install.packages(\"ggplot2\", repos=\"https://cran.rstudio.com\")" | R --no-save
    echo "install.packages(\"readr\", repos=\"https://cran.rstudio.com\")" | R --no-save
%runscript    
    cd /cavatica/data/output
    ln -s ../test/*.tsv .
    ../../code/script.sh
    find /cavatica/data/output -type l | xargs rm
%environment
    export PATH=/:$PATH 

