Bootstrap: docker
From: debian:bookworm-slim

%setup
    mkdir -p ${SINGULARITY_ROOTFS}/batch
    mkdir -p ${SINGULARITY_ROOTFS}/code
    mkdir -p ${SINGULARITY_ROOTFS}/downloads

    install -m 755 ./code/* ${SINGULARITY_ROOTFS}/code

%post
    apt-get -qq update
    apt-get --yes --quiet --no-install-recommends install \
      wget \
      unzip \
      libxext6 \
      libxt6 \
      moreutils \
      build-essential \
      curl \
      ca-certificates
    DEBIAN_FRONTEND=noninteractive apt-get --yes --quiet install \
      octave \
      liboctave-dev

    mkdir /opt/spm12
    curl -fsSL --retry 5 https://github.com/spm/spm12/archive/r7771.tar.gz | tar -xzC /opt/spm12 --strip-components 1
    curl -fsSL --retry 5 https://raw.githubusercontent.com/spm/spm-octave/main/spm12_r7771.patch | patch -p0
    make -C /opt/spm12/src PLATFORM=octave distclean
    make -C /opt/spm12/src PLATFORM=octave
    make -C /opt/spm12/src PLATFORM=octave install
    ln -s /opt/spm12/bin/spm12-octave /usr/local/bin/spm12

    CATversion="r2560"

    cd /downloads
    wget http://www.neuro.uni-jena.de/cat12/cat12_${CATversion}.zip && unzip -d /opt/spm12/toolbox/ cat12_${CATversion}.zip
    rm -fr /downloads

    # install CAT standalone interface
    STANDALONE="/opt/spm12/toolbox/cat12/standalone"
    cd ${STANDALONE} && chmod +rx *.sh
    cd /code && ln -s ${STANDALONE}/*.sh .
    cd /batch && ln -s ${STANDALONE}/*.m .

    # set permissions
    find /code -type f -print0 | xargs -0 chmod +r

    rm -f /opt/spm12/src/*.{mex,o,a}
    apt-get --yes remove build-essential curl liboctave-dev
    apt-get --yes autoremove
    apt-get --yes clean

%environment
    export SPM_HOME=/opt/spm12

%runscript
  exec /code/main "$@"

%labels
    Author fil.spm@ucl.ac.uk
            Malgorzata Wierzba (m.wierzba@fz-juelich.de)
            Felix Hoffstaedter (f.hoffstaedter@fz-juelich.de)
    Version v1.1

%help
    This is a container with SPM12, CAT12 and GNU Octave.

This container allows to run the standalone version of the
Computational Anatomy Toolbox (CAT), which is an extension to SPM
software using Octave 7.3.0

The container runs Debian bookworm-slim and includes:

- Octave (7.3.0)
- Standalone version of SPM software (SPM12, r7771)
- Computational Anatomy Toolbox (CAT12.9 ${CATversion})
- CAT interface scripts (cat_standalone.sh, cat_parallelize.sh).

For more details on the exact version of the software used in this
container, please refer to the README file.


HOW TO USE:

In principle this container allows you to perform the very same types
of analysis that are possible with the standalone version of CAT. It
is assumed that the user is familiar with the content of the batch
files dedicated for the use with the standalone version of CAT
(cat_standalone_segment.m, cat_standalone_simple.m,
cat_standalone_resample.m, cat_standalone_smooth.m) and can modify
their content according to his/her needs. For more details, please
refer to the CAT12 documentation and manual.


-- Available batch files --

The content of the batch files can be explored by using the 'view' and
'copy' subcommands:

singularity run <container> <subcommand> <batch file> <arguments>

To view a batch file, use the 'view' subcommand:

singularity run container.simg view cat_standalone_smooth.m

To copy a batch file to your computer, use the 'copy' subcommand and
specify destination path as an additional argument:

singularity run container.simg copy cat_standalone_smooth.m $HOME

Make sure that the specified path is mounted to the container (more
information on this can be found below) and that you have write access
to this path!

To copy all available batch files, use the 'all' argument:

singularity run container.simg copy all $HOME


-- Running CAT --

Run the CAT analysis with the following command:
singularity run --cleanenv <container> <batch file> <arguments>

To use a default batch file, use one of the files included in the
container ('/batch'):
singularity run --cleanenv container.simg \
	-b /batch/cat_standalone_segment.m \
	T1.nii

To use your own, customised batch file, simply specify its path:
singularity run --cleanenv container.simg \
	-b $HOME/cat_standalone_segment.m \
	T1.nii


-- Bind paths --

Please note that most of the host files remain inaccessible from within
the container. By default the following directories are mounted within
the container: '$HOME', '/tmp', '/proc', '/sys', '/dev', and '$PWD'
(see the Singularity documentation for more details).

If you want the container to be able to access other locations,
specify a bind path of your choice. For instance, to make the contents
of the '/data' folder on your computer available in the '/mnt' folder
inside the container, specify the mount point in the following way:

singularity run --cleanenv --bind /data:/mnt container.simg \
	-b /batch/cat_standalone_segment.m \
	/mnt/T1.nii


EXAMPLES:

CAT12 segmentation batch:
singularity run --cleanenv container.simg \
	-b cat_standalone_segment.m \
	T1.nii

CAT12 simple processing batch:
singularity run --cleanenv container.simg \
	-b cat_standalone_simple.m \
	T1.nii

CAT12 resample & smooth batch:
singularity run --cleanenv container.simg \
	-b cat_standalone_resample.m \
	-a1 "12" -a2 "1" \
	lh.thickness.T1

CAT12 volume smoothing batch:
singularity run --cleanenv container.simg \
	-b cat_standalone_smooth.m \
	-a1 "[6 6 6]" -a2 "'s6'" \
	T1.nii



Contact information:

Any problems or concerns regarding this container should be reported
to Felix Hoffstaedter (f.hoffstaedter@fz-juelich.de) and regarding
CAT12 to Christian Gaser (christian.gaser@uni-jena.de)


Acknowledgements:

The CAT toolbox (http://www.neuro.uni-jena.de/cat) is developed by
Christian Gaser and Robert Dahnke (Jena University Hospital,
Departments of Psychiatry and Neurology) and is free but copyright
software, distributed under the terms of the GNU General Public
Licence.

The SPM software (https://www.fil.ion.ucl.ac.uk/spm/) is developed by
the Wellcome Trust Centre for Neuroimaging and is free but copyright
software, distributed under the terms of the GNU General Public
Licence (GPL).

GNU Octave is a freely redistributable software under the terms of
the GPL as published by the Free Software Foundation.
