Bootstrap: docker
From: r-base

%runscript
    Rscript -e 'plinkr::plinkr_report()'

%post
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    apt-get -y install libssl-dev libcurl4-openssl-dev libxml2-dev
    apt-get clean
    Rscript -e 'install.packages("remotes")'
    Rscript -e 'install.packages("devtools")'
    Rscript -e 'remotes::install_github("richelbilderbeek/plinkr")'
    Rscript -e 'plinkr::install_plinks()'

