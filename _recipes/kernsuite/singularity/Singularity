Bootstrap: debootstrap
MirrorURL: http://archive.ubuntu.com/ubuntu/
OSVersion: bionic
Include: software-properties-common
%post
    add-apt-repository -s ppa:kernsuite/kern-5
    apt-add-repository multiverse
    apt-add-repository restricted
    apt-get update
    apt-get dist-upgrade -y
    apt-get install -y \
    libblitz0-dev pyxis python-xmlrunner tempo casacore-dev casacore-doc casacore-tools casarest factor \
    casacore-data meqtrees-timba kittens purr python-purr python-meqtrees-cattery python-owlcat python-pyxis \
    python-meqtrees-timba makems rpfits meqtrees libmeqtrees-timba0 aoflagger wsclean sagecal oskar python-pyfftw \
    python3-pyfftw python-casacore python-attrdict python-pymoresane obit parseltongue python-typing python3-casacore \
    psrcat tempo2 multinest dspsr \
    chgcentre python-tkp aoflagger-dev libaoflagger0 wsclean-dev python-graphviz python-katversion python-katpoint \
    python-katdal python-rfimasker python3-graphviz simfast21 dysco 21cmfast stimela msutils casalite cub-dev \
    python-transitions python3-transitions python-scatterbrane tmv-dev drive-casa sigpyproc python3-xmlrunner tirific \
    karma aips losoto lsmtool tigger rmextract python3-attrdict libtmv-symband0 libtmv0 dyscostma-dev libdyscostman0 \
    owlcat pymoresane python-sharedarray python3-sharedarray pybdsf libblitz0 python-shm \
    python-slalib python-guppi-daq python-turbo-seti turbo-seti python-bitshuffle python3-bitshuffle gbt-seti \
    ctypesgen heimdall-astro python3-slalib rfimasker tigger-lsm \
    python-astro-kittens python3-astro-kittens python-astro-tigger-lsm python-astro-tigger difmap sched ppgplot \
    python-pymonetdb python3-pymonetdb polygon2 ddfacet libwsclean2 libpsrbase0 \
    libpsrmore0 libpsrplot0 libpsrutil0 \
    libisautils libisaopencl astrodata dedispersion integration snr dadafilterbank \
    dadafits coast-guard psrfits-utils ymw16 python-kapteyn libelementresponse2 libstationresponse2 apsynsim \
    python-eigency python3-eigency bitshuffle-hdf5-plugin python-spead2 python3-spead2 spead2 miriad dp3 python-dp3 \
    libcasa-casa3 libcasa-coordinates3 libcasa-derivedmscal3 libcasa-fits3 libcasa-images3 libcasa-lattices3 \
    libcasa-meas3 libcasa-measures3 libcasa-mirlib3 libcasa-ms3 libcasa-msfits3 libcasa-python3-3 libcasa-python3 \
    libcasa-scimath-f3 libcasa-scimath3 libcasa-tables3 python-pyfftw-doc dspsr-dev libidg bifrost astro-amber carta \
    lofarbeam-dev carta-remote libelementresponse3 libstationresponse3 \
    python3-nifty

    apt-get clean
