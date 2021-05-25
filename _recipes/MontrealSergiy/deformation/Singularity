Bootstrap: docker
From: nistmni/minc-toolkit-min:1.9.16

%files
    deformation.pl /usr/local/bin/deformation.pl
    deformation_2.pl /usr/local/bin/deformation_2.pl

%post
    apt-get update && apt-get install -y build-essential gfortran automake libtool git
    # minc tool paths
    . /opt/minc/1.9.16/minc-toolkit-config.sh
    echo ". /opt/minc/1.9.16/minc-toolkit-config.sh" >> $SINGULARITY_ENVIRONMENT
    echo "export PATH=/opt/dfg/bin:$PATH" >> $SINGULARITY_ENVIRONMENT
    pip install Cython

    # download
    git clone https://github.com/Mouse-Imaging-Centre/generate_deformation_fields
    cd generate_deformation_fields
    mkdir /opt/dfg
    ./autogen.sh
    ./configure --prefix=/opt/dfg --with-minc2 --with-build-path=/opt/minc/1.9.16
    make
    make install
    cd scripts
    python setup.py build_ext --inplace
    python setup.py install --prefix=/opt/dfg --install-lib=/usr/local/lib/python2.7/dist-packages

    chmod +x /usr/local/bin/deformation.pl
    chmod +x /usr/local/bin/deformation_2.pl

%test
    grep -q NAME=\"Ubuntu\" /etc/os-release
    if [ $? -eq 0 ]; then
        echo "Container base is Ubuntu as expected."
    else
        echo "Container base is not Ubuntu."
    fi

%labels
    Author Naj Nurani
    Version v0.0.1

%help
    This is a brain deformation field computation script that consists from a perl wrapper and a software
    This PERL script is a wrapper that is calling sequence of commands for generating deformation fields scrips
    from      https://wiki.mouseimaging.ca/display/MICePub/Generating+deformation+fields

    usage example is

    deformation_2.pl -input ICBM_00100_t1_final.mnc        `# this could be any anatomical minc file`\
                      -output dummy_hoho \
                      -deformation_ratio 0.6 \
                      -coordinate 70 100 70 10 10 10 \
                      -tolerance_space 4 `# default`\
                      -blur_determinant 0.25 `# default`\
                      -error 0.00001 \
                      -iteration 100

the text in backtick are comments, can be omitted
