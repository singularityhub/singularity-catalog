From: ubuntu:16.04
Bootstrap: docker

# sudo singularity build dinosaur-data Singularity

# Unmount a squashfs filesystem

%apprun unmount
    # mount file.sqsh /tmp/dest
    exec mkdir -p "${1}" fusermount -u "${1}"

%apphelp unmount
    Unmount a squashfs file system
        singularity run --app unmount --bind local.sqsh:/scif/data.sqsh dinosaur-data

# Mount a squashfs filesystem

%apphelp mount
    Mount a squashfs file to a folder where you have write on you computer!
    The folder should NOT exist (but you should have writable to where it would)
    as the container will create it for you.
        singularity run --app mount dinosaur-data data.sqsh /tmp/data

%apprun mount
    # mount file.sqsh /tmp/dest
    exec squashfuse /opt/data.sqsh /tmp/data

%apphelp create
    Create a squashfs file system from a folder
        singularity run --app create dinosaur-data /tmp/data.sqsh /tmp/data

%apprun create
    exec mksquashfs "${1}" "${2}"

%post
    apt-get update && apt-get install -y fuse libfuse2 git zlib1g-dev \
                      autoconf libtool make gcc pkg-config xz-utils \
                      libtool libfuse-dev liblzma-dev squashfs-tools

    git clone https://github.com/vasi/squashfuse
    cd squashfuse
    libtoolize --force
    aclocal
    autoheader
    automake --force-missing --add-missing
    autoconf
    ./configure --with-xz=/usr/lib/ --prefix=/usr/local
    make
    make install

    echo "user_allow_other" >> /etc/fuse.conf
    chown root /bin/fusermount
    chmod u+s /bin/fusermount

    echo "/scif/data.sqsh  /scif/data       squashfs        ro,user,noauto,unhide,loop" >> /etc/fstab

    ldconfig
    mkdir -p /scif/data
    chmod --recursive ugo+rw /scif/data
    mount -a
