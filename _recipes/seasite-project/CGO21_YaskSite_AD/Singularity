Bootstrap: docker
From: ubuntu:latest

%post
    apt-get clean && apt-get update
    apt-get install -y locales
    localedef -i en_US -f UTF-8 en_US.UTF-8
    apt-get install -y build-essential
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -y cmake
    apt-get install -y cmake-curses-gui
    apt-get install -y git
    apt-get install -y vim
    apt install -y software-properties-common
    add-apt-repository -y  ppa:deadsnakes/ppa
    apt install -y python3.8
    apt install -y python
    apt-get install -y bc
    apt-get install -y unzip
    apt-get install -y wget
    apt-get install -y libpcre3-dev
    apt-get install -y  python3-pip
    pip3 install --user wheel
    wget https://registrationcenter-download.intel.com/akdlm/irc_nas/17431/l_BaseKit_p_2021.1.0.2659_offline.sh
    chmod +x l_BaseKit_p_2021.1.0.2659_offline.sh
    sh ./l_BaseKit_p_2021.1.0.2659_offline.sh -a --silent --eula accept --components intel.oneapi.lin.dpcpp-cpp-compiler:intel.oneapi.lin.dpcpp-library
    rm l_BaseKit_p_2021.1.0.2659_offline.sh
    wget https://registrationcenter-download.intel.com/akdlm/irc_nas/17427/l_HPCKit_p_2021.1.0.2684_offline.sh 
    chmod +x l_HPCKit_p_2021.1.0.2684_offline.sh
    sh ./l_HPCKit_p_2021.1.0.2684_offline.sh -a --silent --eula accept --components intel.oneapi.lin.dpcpp-cpp-compiler-pro:intel.oneapi.lin.mpi.devel
    rm l_HPCKit_p_2021.1.0.2684_offline.sh
    git clone https://github.com/RRZE-HPC/likwid.git
    cd likwid
    cp config.mk config_old.mk
    sed -e "s@ACCESSMODE = accessdaemon@ACCESSMODE = perf_event@g" config_old.mk > config.mk
    make  && make install
    cd -
    echo "export PATH=\"${PATH}\"" >> $SINGULARITY_ENVIRONMENT

%help
    This is a singularity container that reproduces result from CGO2021 paper
    "YaskSite – Stencil Optimization Techniques Appliedto Explicit ODE Methods
    on Modern Architectures". 
    There are different apps available to find help of each app use the following:
    'singularity run-help --app <app_name> <container_name>'.
    Following are the available apps:
    * build (This is the first app to run before anything else)
    * YaskSite (advanced, not needed to reproduce results)
    * Offsite (advanced, not needed to reproduce results)
    * Fig4
    * Fig6
    * Fig7
    * Fig8prediction 
    * Fig8measurement

%environment
   export SINGULARITY_BASE_PATH=${PWD}
   #export SINGULARITY_RUN_PATH=${PATH}
   export PYTHONPATH=${SINGULARITY_BASE_PATH}/installkit/lib/python3.8/site-packages/
   export PATH=$PATH:${SINGULARITY_BASE_PATH}/installkit/bin/

###### Build YaskSite, it has to be done on the running machine therefore as runscript #######
%apphelp build
    App for building YaskSite, kerncraft and Offsite. This is the first app to run before running anything else.
    It installs YaskSite, since it detects the machine when building this build process is made as
    an app and user should run this on the machine where they are running the rest of the benchmarks.
    Currently YaskSite supports the following architecures Intel Sandy Bridge, Ivy Bridge, Haswell, Broadwell, Skylake, Cascade Lake  and AMD Naples, ROME.
    To run it use 'singularity run --app build <container_name>'

%apprun build
    cd ${SINGULARITY_BASE_PATH}
    rm kerncraft -rf
    rm Offsite -rf
    rm installkit -rf
    rm tmp -rf
    rm tmp_YaskSite -rf
    rm YaskSite -rf

    wget https://zenodo.org/record/4283028/files/seasite-project/YaskSite-v0.4.7.zip?download=1 -O YaskSite.zip
    unzip YaskSite.zip
    mv seasite-project-YaskSite-663ac01 YaskSite
    cd YaskSite
    mkdir build && cd build
    bash -c "source /opt/intel/oneapi/setvars.sh && CC=icc CXX=icpc cmake .. -DI_AGREE_ALL_TERMS_AND_CONDITIONS=true -DCMAKE_INSTALL_PREFIX=${SINGULARITY_BASE_PATH}/installkit -DTEMP_DIR=${SINGULARITY_BASE_PATH}/tmp_YaskSite -DLIKWID_LIBRARIES=/usr/local/lib/liblikwid.so -DLIKWID_INCLUDE_DIR=/usr/local/include -DCMAKE_C_COMPILER=icc -DCMAKE_CXX_COMPILER=icpc -DMPIEXEC_EXECUTABLE=/opt/intel/oneapi/mpi/2021.1.1/bin/mpiexec -DMPI_C_HEADER_DIR=/opt/intel/oneapi/mpi/2021.1.1/include/ -DMPI_CXX_HEADER_DIR=/opt/intel/oneapi/mpi/2021.1.1/include/ -DMPI_C_ADDITIONAL_INCLUDE_DIRS=/opt/intel/oneapi/mpi/2021.1.1/include/ -DMPI_CXX_ADDITIONAL_INCLUDE_DIRS=/opt/intel/oneapi/mpi/2021.1.1/include/ && make && make install"
    cd ../example
    mkdir build && cd build
    bash -c "source /opt/intel/oneapi/setvars.sh && CC=icc CXX=icpc cmake .. -DyaskSite_DIR=${SINGULARITY_BASE_PATH}/installkit && make"
    cd ${SINGULARITY_BASE_PATH}
    cd run_variant/YaskSite
    mkdir -p  build
    cd build
    bash -c "source /opt/intel/oneapi/setvars.sh && CC=icc CXX=icpc cmake .. -DyaskSite_DIR=${SINGULARITY_BASE_PATH}/installkit && make"
    cd ${SINGULARITY_BASE_PATH}
    echo "Building YaskSite success"

    cd $SINGULARITY_BASE_PATH
    git clone https://github.com/RRZE-HPC/kerncraft && cd kerncraft
    git checkout v0.8.5
    export PYTHONPATH=${SINGULARITY_BASE_PATH}/installkit/lib/python3.8/site-packages/
    export PATH=$PATH:${SINGULARITY_BASE_PATH}/installkit/bin/
    python3 setup.py bdist_wheel && pip3 install --prefix=${SINGULARITY_BASE_PATH}/installkit dist/kerncraft*.whl
    iaca_get --I-accept-the-Intel-What-If-Pre-Release-License-Agreement-and-please-take-my-soul
    cd $SINGULARITY_BASE_PATH
    wget https://zenodo.org/record/4283107/files/seasite-project/Offsite-v0.2.0cgo21.zip?download=1 -O Offsite.zip
    unzip Offsite.zip -d Offsite
    cd Offsite/seasite-project-Offsite-3509342
    python3 setup.py bdist_wheel && pip3 install --prefix=${SINGULARITY_BASE_PATH}/installkit dist/offsite*.whl
    cd $SINGULARITY_BASE_PATH
    echo "Building Offsite success"

##### App for running yasksite ######
%apphelp YaskSite
    This is the complete YaskSite app. To see help options type 'singularity run --app YaskSite <container_name> "-h"'.
    Remember: Please pass arguments as a string, i.e., for example to run Wave3D, radius 1 with 20 cores and inner-dimensions in range 500:20:800 on Cascade Lake Gold 6248
    use 'singularity run --app YaskSite <container_name> "-k Wave3D:3 -m machines/CascadelakeSP_Gold-6248.yml -R 500:20:800 -c 20 -t 1 -f auto -r 1 -O spatial -o <out folder>"'

%apprun YaskSite
    cd $SINGULARITY_BASE_PATH
    echo "Running YaskSite with arguments $*"
    threads=$(echo "$*" | grep -o -P "\-c.*" | cut -d"-" -f2 | cut -d"c" -f 2)
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid $@"

###### App for reproducing Fig. 4 plots #######
%apphelp Fig4
    Reproduces result in Figure 4 of the paper.

    Input arguments are machine file, threads.
    * machine file - The machine file corresponding to the architecture we considered is examples/machines/CascadelakeSP_Gold-6248.yml.
    * threads - For reproducing the results in the paper set threads to number of cores on 1 socket (20 on CLX which we tested).

    For example for CLX with 20 threads : 'singularity run --app Fig4 <container_name> "-m <machine_file> -c <ncores>"'

    The app outputs CSV files in results/Fig4 folder. 
    The column corresponding to 'mlups' is the measurement and 'ECM_mlups' is the prediction.

%apprun Fig4
    cd $SINGULARITY_BASE_PATH
    mkdir -p results
    echo "Running Fig4 with arguments $*"
    threads=$(echo "$*" | grep -o -P "\-c.*" | cut -d"-" -f2 | cut -d"c" -f 2)
    rm -rf results/Fig4
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 1 -O plain:spatial -o results/Fig4 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 1 -O plain:spatial -o results/Fig4 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 4 -O plain:spatial -o results/Fig4 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 4 -O plain:spatial -o results/Fig4 $@"

###### App for reproducing Fig. 6 plots #######
%apphelp Fig6
    Reproduces result in Figure 6 of the paper.

    Input arguments are machine file, threads.
    * machine file - The machine files corresponding to the architecture we considered are examples/machines/CascadelakeSP_Gold-6248.yml, examples/machines/examples/machines/Zen_ROME-7452.yml.
    * threads - For reproducing the results in the paper set threads to number of cores on 1 socket (20 on CLX and 32 on ROME which we tested).

    For example for CLX and 20 threads : 'singularity run --app Fig6 <container_name> "-m <machine_file> -c <ncores>"'

    The app outputs CSV files in results/Fig6 folder. 
    The entries in column corresponding to 'mlups' are the required performance and 'AT time' column correspond to tuning time.
    The 'plain', 'spatial' and 'AT' corrspond to 'plain', 'analytical' and 'GD' keywords in the figure.
    The plot can be produced by taking the statistics over all sizes in the output files.

%apprun Fig6
    cd $SINGULARITY_BASE_PATH
    mkdir -p results
    echo "Running Fig6 with arguments $*"
    rm -rf results/Fig6
    threads=$(echo "$*" | grep -o -P "\-c.*" | cut -d"-" -f2 | cut -d"c" -f 2)
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 1 -O plain:spatial:AT -o results/Fig6 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 1 -O plain:spatial:AT -o results/Fig6 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 2 -O plain:spatial:AT -o results/Fig6 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 2 -O plain:spatial:AT -o results/Fig6 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 4 -O plain:spatial:AT -o results/Fig6 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:1000 -f auto -r 4 -O plain:spatial:AT -o results/Fig6 $@"


###### App for reproducing Fig. 7 plots #######
%apphelp Fig7
    Reproduce result in Figure 7 of the paper.

    Input arguments are machine file, threads.
    * machine file - The machine file corresponding to the architecture we considered is examples/machines/CascadelakeSP_Gold-6248.yml.
    * threads - For reproducing the results in the paper set threads to number of cores on 1 socket (20 on CLX which we tested).

    For example for CLX and 20 threads : 'singularity run --app Fig7 <container_name> "-m <machine_file> -c <ncores>"'

    The app outputs CSV files in results/Fig7 folder.
    The column corresponding to 'mlups' is the measurement and 'ECM_mlups' is the prediction.
    Note the run will take long time (approx. 3 hours).

%apprun Fig7
    cd $SINGULARITY_BASE_PATH
    mkdir -p results
    echo "Running Fig7 with arguments $*"
    rm -rf results/Fig7
    threads=$(echo "$*" | grep -o -P "\-c.*" | cut -d"-" -f2 | cut -d"c" -f 2)
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:1:8 -r 1 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:1:8 -r 1 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:8:1 -r 1 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:8:1 -r 1 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 2:2:2 -r 1 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 2:2:2 -r 1 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 4:2:1 -r 1 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 4:2:1 -r 1 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 8:1:1 -r 1 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 8:1:1 -r 1 -o results/Fig7 $@"


    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:1:8 -r 4 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:1:8 -r 4 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:8:1 -r 4 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 1:8:1 -r 4 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 2:2:2 -r 4 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 2:2:2 -r 4 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 4:2:1 -r 4 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 4:2:1 -r 4 -o results/Fig7 $@"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 8:1:1 -r 4 -o results/Fig7 $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && likwid-pin -c S0:0-$((threads-1)) perf_wo_likwid -k Wave3D:3 -t 1 -R 20:20:400 -O plain -f 8:1:1 -r 4 -o results/Fig7 $@"

##### App for running Offsite ########
%apphelp Offsite
    App for running Offsite. Please refer to Offsite help to get more information on input arguments.
    Offsite help can be found by using 'singularity run --app Offsite <container_name> "-h"'.
    Run Offsite using 'singularity run --app Offsite <container_name> "<input_arguments>"'.


%apprun Offsite
    cd $SINGULARITY_BASE_PATH
    echo "Running Offsite with arguments $*"
    bash -c "PYTHONPATH=${SINGULARITY_BASE_PATH}/installkit/lib/python3.8/site-packages/ && PATH=$PATH:YaskSite/example/build:${SINGULARITY_BASE_PATH}/installkit/bin/ && source /opt/intel/oneapi/setvars.sh && offsite_tune $@"

#### App for running Fig8 and Table 3 prediction results #######
%apphelp Fig8prediction
    Reproduce prediction results in Figure 8 and Table 3 of the paper with the use of Offsite.

    Input arguments are machine file, config file and ivp.
    * machine file - The machine files corresponding to the architecture we considered are examples/machines/CascadelakeSP_Gold-6248.yml, examples/machines/examples/machines/Zen_ROME-7452.yml.
    * config file - These contain the settings like fold sizes and blocking. Config files corresponding to CLX and ROME are in examples/config/config_clx.tune and examples/config/config_rome.tune
    * ivp - Defines the IVP problem. IVP files can be found in examples/ivps/*
    * output database name - Specify the output database name

    For example for CLX with Wave3d, radius=2 IVP use
    'singularity run --app Fig8prediction <container_name> "--machine examples/machines/CascadelakeSP_Gold-6248.yml --config examples/config/config_clx.tune --ivp examples/ivps/Wave3D_radius2.ivp --db Fig6_Wave3d_radius2.db"'

    The output will be in SQL database 'Fig8_Wave3d_radius2.db'(see 'impl_variant_prediction' table).
    If the same machine files as in the paper are used it will additionally
    convert SQL database to csv and write it in results/Fig8prediction folder.
    Expect 8-10 hours to run this, since it generates different YASK kernels and tests them.
    Also it needs diskspace (10 GB) as the generated kernels will be cached for later execution in Fig6measurements app.

%apprun Fig8prediction
    mkdir -p results
    export PYTHONPATH=${SINGULARITY_BASE_PATH}/installkit/lib/python3.8/site-packages/
    export PATH=$PATH:${SINGULARITY_BASE_PATH}/installkit/bin/
    cd $SINGULARITY_BASE_PATH
    echo "Running Fig8prediction with arguments $*"
    echo "executing export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && offsite_tune --tool yasksite --compiler icc --impl examples/impls/pirk/ --kernel examples/kernels/pirk/ --method examples/methods/implicit/radauIIA7.ode --mode MODEL --verbose --filter-yasksite-opt $@"
    bash -c "export PATH=$PATH:YaskSite/example/build && source /opt/intel/oneapi/setvars.sh && offsite_tune --tool yasksite --compiler icc --impl examples/impls/pirk/ --kernel examples/kernels/pirk/ --method examples/methods/implicit/radauIIA7.ode --mode MODEL --verbose --filter-yasksite-opt $@"
    bash -c "export PATH=$PATH:${SINGULARITY_BASE_PATH}/installkit/bin/ && export PYTHONPATH=${SINGULARITY_BASE_PATH}/installkit/lib/python3.8/site-packages/ && ${SINGULARITY_BASE_PATH}/db2csv.sh $@ -o results/Fig8prediction"

#### App for running Fig8 and Table 3 measurement results #####
%apphelp Fig8measurement
    Reproduce measurement results in Figure 8 and Table 3 of the paper.
    Note: This can be run only after running 'Fig8prediction' app, since the cached kernels produced by 'Fig8prediction' are required here.

    The input arguments are number of threads, machine file, IVP kernel, radius and config file.
    * threads = For reproducing the results in the paper set threads to number of cores on 1 socket (20 on CLX and 32 on ROME which we tested).
    * machine file = The machine files corresponding to the architecture we considered are examples/machines/CascadelakeSP_Gold-6248.yml, examples/machines/examples/machines/Zen_ROME-7452.yml.
    * config file = These contain the settings like fold sizes and blocking. Config files corresponding to CLX and ROME are in examples/config/config_clx.tune and examples/config/config_rome.tune
    * IVP kernel = This is either Heat3D, Wave3D_radius2  or Wave3D_radius4 depending on the IVP problem.

    For example for running Wave3D, radius 2, on Intel CLX use: 
    'singularity run --app Fig8measurement <container_name> "-c 20 -m examples/machines/CascadelakeSP_Gold-6248.yml -k Wave3D_radius2 -r 2 --config examples/config/config_clx.tune"'

    This will write results to a folder called 'results/Fig8measurement'.

%apprun Fig8measurement
    cd $SINGULARITY_BASE_PATH
    echo "Running Fig6measurement with arguments $*"
    rm -rf results/Fig6measurement
    echo "executing source /opt/intel/oneapi/setvars.sh && run_variant/YaskSite/run_script.sh -p run_variant/YaskSite/build -o results/Fig6measurement $@"
    bash -c "source /opt/intel/oneapi/setvars.sh && run_variant/YaskSite/run_script.sh -p run_variant/YaskSite/build -o results/Fig8measurement $@"
