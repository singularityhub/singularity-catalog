BootStrap: docker
From: ubuntu:22.04

%setup


%files
    # copying files from the host system to the container.
    excel2xml_dra.rb /usr/local/bin
    validate_meta_dra.rb /usr/local/bin
    excel2xml_jga.rb /usr/local/bin
    validate_meta_jga.rb /usr/local/bin


%environment
    export RUBYOPT='-EUTF-8'


%labels
    Maintainer Bioinformation and DDBJ Center
    Version    v2.0


%runscript



%post
    echo "Hello from inside the container"
    sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    sed -i.bak -e "s%http://security.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
    export DEBIAN_FRONTEND="noninteractive"
    apt-get -y update
    apt-get -y upgrade
    apt -y install locales
    locale-gen en_US.UTF-8
    update-locale
    apt -y install vim less build-essential autoconf automake wget git zlib1g-dev libbz2-dev libncurses5-dev curl unzip liblzma-dev libcurl4-openssl-dev software-properties-common apt-transport-https libyaml-dev libffi-dev libssl-dev libreadline-dev libxml2-dev libxml2-utils software-properties-common python2-dev
    cd /usr/local/src
    wget https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz
    tar xzf ruby-3.2.2.tar.gz
    cd ruby-3.2.2
    ./configure --prefix=/usr
    make
    make install
    gem install open3 -v "0.1.2"
    gem install mini_portile2 -v "2.4.0"
    gem install nokogiri -v "1.15.3"
    gem install rubyzip -v "2.3.2"
    gem install roo -v "2.10.0"
    gem install builder -v "3.2.4"
    gem install date -v "3.0.0"
    gem install rexml -v "3.2.5"

    chmod +x /usr/local/bin/excel2xml_dra.rb
    chmod +x /usr/local/bin/validate_meta_dra.rb
    chmod +x /usr/local/bin/excel2xml_jga.rb
    chmod +x /usr/local/bin/validate_meta_jga.rb
    mkdir -p /opt/submission-excel2xml
    cd /opt/submission-excel2xml
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.analysis.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.annotation.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.common.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.experiment.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.package.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.run.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.sample.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.study.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/dra/xsd/1-5/SRA.submission.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.analysis.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.common.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.dac.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.data.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.dataset.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.experiment.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.policy.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.sample.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.study.xsd
    wget https://raw.githubusercontent.com/ddbj/pub/master/docs/jga/xsd/1-2/JGA.submission.xsd