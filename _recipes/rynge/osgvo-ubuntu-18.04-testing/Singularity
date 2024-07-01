bootstrap:docker
From:ubuntu:bionic

%post

apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        lsb-release \
        curl \
        module-init-tools \
        openjdk-8-jdk \
        pkg-config \
        python \
        python-dev \
        python-numpy \
        rsync \
        unzip \
        vim \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# stashcp
wget -nv -O /usr/bin/caches.json https://raw.githubusercontent.com/djw8605/StashCache-1/add-http/bin/caches.json && \
    wget -nv -O /usr/bin/stashcp https://raw.githubusercontent.com/djw8605/StashCache-1/add-http/bin/stashcp && \
    chmod 755 /usr/bin/stashcp

# CA certs
mkdir -p /etc/grid-security && \
    cd /etc/grid-security && \
    wget -nv https://download.pegasus.isi.edu/containers/certificates.tar.gz && \
    tar xzf certificates.tar.gz && \
    rm -f certificates.tar.gz

# required directories
for MNTPOINT in \
        /cvmfs \
        /hadoop \
        /hdfs \
        /lizard \
        /mnt/hadoop \
        /mnt/hdfs \
        /xenon \
        /spt \
        /stash2 \
    ; do \
        mkdir -p $MNTPOINT ; \
    done

# build info
echo "Timestamp:" `date --utc` | tee /image-build-info.txt



