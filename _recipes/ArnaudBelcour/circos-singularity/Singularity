Bootstrap: docker
From: ubuntu:18.04

%environment
    export PATH=$PATH:/opt/circos-0.69-6/bin
    export LC_ALL=C.UTF-8
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8 

%post
    apt-get update ;\
    apt-get install -y \
    wget \
    git \
    bzip2 \
    build-essential \
    gcc \
    zlib1g-dev \
    make \
    cmake \
    unzip \
    curl \
    pkg-config \
    libgd-gd2-perl \
    libgd-svg-perl \
    libdata-clone-perl \
    language-pack-en-base ;\

    curl -L https://cpanmin.us | perl - App::cpanminus ;\
    cpanm Clone \
    Config::General \
    Font::TTF::Font \
    Math::VecStat \
    Math::Bezier \
    Math::Round \
    Readonly \
    Regexp::Common \
    Text::Format \
    Set::IntSpan \
    List::MoreUtils \
    Params::Validate \
    Statistics::Basic ;\

    cd /opt ;\
    wget http://circos.ca/distribution/circos-0.69-6.tgz ;\
    tar -xvf circos-0.69-6.tgz ;\
    rm circos-0.69-6.tgz
    cd /opt/circos-0.69-6/bin ;\
    chmod u+x *