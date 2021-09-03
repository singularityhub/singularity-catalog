bootstrap: docker
from: bdgenomics/rhapsody:1.9.1

%help
    Contains:
        - tools from docker:bdgenomics/rhapsody image
        - cwltool for cwl-runner
        - nodejs
        - git
        - Code from https://bitbucket.org/CRSwDev/cwl.git but with docker/singularity requirements removed in rhapsody_targeted_1.9.1.cwl and v1.9.1/rhapsody_wta_1.9.1.cwl (since the entire pipeline runs within the container).
    This allows to run the BD Genomics Rhapsody Analysis Pipeline CWL entirely within a container.
        
%post
    set -eu
    
    # Build date (when building, pass via SINGULARITYENV_CONTAINER_BUILD_DATE otherwise date when building)
    if [ -z ${CONTAINER_BUILD_DATE+x} ]
    then
      CONTAINER_BUILD_DATE=$(date)
    fi
    echo "export CONTAINER_BUILD_DATE=\"${CONTAINER_BUILD_DATE}\"" >> $SINGULARITY_ENVIRONMENT
    
    # Git repository names (when building, pass via SINGULARITYENV_CONTAINER_GIT_NAME otherwise empty)
    if [ -z ${CONTAINER_GIT_NAME+x} ]
    then
      CONTAINER_GIT_NAME=''
    fi
    echo "export CONTAINER_GIT_NAME=\"${CONTAINER_GIT_NAME}\"" >> $SINGULARITY_ENVIRONMENT
    
    # Git repository url (when building, pass via SINGULARITYENV_CONTAINER_GIT_URL otherwise empty)
    if [ -z ${CONTAINER_GIT_URL+x} ]
    then
      CONTAINER_GIT_URL=''
    fi
    echo "export CONTAINER_GIT_URL=\"${CONTAINER_GIT_URL}\"" >> $SINGULARITY_ENVIRONMENT
    
    # Git repository commit id (when building, pass via SINGULARITYENV_CONTAINER_GIT_COMMIT_ID otherwise empty)
    if [ -z ${CONTAINER_GIT_COMMIT_ID+x} ]
    then
      CONTAINER_GIT_COMMIT_ID=''
    fi
    echo "export CONTAINER_GIT_COMMIT_ID=\"${CONTAINER_GIT_COMMIT_ID}\"" >> $SINGULARITY_ENVIRONMENT
    
    # so that apt-get can be run non-interactively
    export DEBIAN_FRONTEND=noninteractive
    
    # install nodejs
    apt-get clean && apt-get --allow-releaseinfo-change update -y && apt-get upgrade -y
    apt-get install -y nodejs git
    
    # install cwltool (use pip to get newest version)
    pip install cwlref-runner
    
    # get BD Genomics Rhapsody Analysis Pipeline CWL from bitbucket 
    cd / && git clone https://bitbucket.org/CRSwDev/cwl.git
    
    # remove docker/singularity requirements since entire pipeline runs within container
    perl -i.original -0777  -pe 's/\{[^\}]+DockerRequirement[^\}]+\},?//g' /cwl/v1.9.1/rhapsody_wta_1.9.1.cwl
    perl -i.original -0777  -pe 's/\{[^\}]+DockerRequirement[^\}]+\},?//g' /cwl/v1.9.1/rhapsody_targeted_1.9.1.cwl
    
##############################

# BD Rhapsody WTA pipeline   #

##############################

%apphelp wta-config
    Generates a configuration YAML file for the wta/wta-parallel app.
    
%apprun wta-config
    echo "Generating a configuration YAML file for the wta app"
    cp /cwl/v1.9.1/template_wta_1.9.1.yml .

%apphelp wta
    Run the app without arguments to see available options.
    
%apprun wta
    echo "Running the BD Rhapsody Whole Transcriptome Analysis (WTA) pipeline"
    if [ $# -eq 0 ]
    then
      cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_wta_1.9.1.cwl --help
      echo
      echo "Alternatively, generate a configuration YAML file with the app wta-config and pass it as argument."
      echo
      echo "Make sure:
    - fastq file pairs contain a _R1_ or a _R2_ and have the same prefix
    - fastq headers follow this format: @READNAME [12]:N:0:SAMPLE_BARCODE
    - there is enough space in /tmp; if not, run with SINGULARITYENV_TMPDIR=path/to/some/directory singularity run ... (make sure the path is bound)
    - reference genome is a tar.gz STAR index
    - transcriptome annotation is a gtf file
    - quote strings in configuration YAML file"
      echo
    else
      echo "# cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_wta_1.9.1.cwl $@"
      cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_wta_1.9.1.cwl $@
    fi
    echo
    
%apphelp wta-parallel
    Run the app without arguments to see available options. This app will run jobs in parallel.
    
%apprun wta-parallel
    echo "Running the BD Rhapsody Whole Transcriptome Analysis (WTA) pipeline (parallel version)"
    if [ $# -eq 0 ]
    then
      cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_wta_1.9.1.cwl --help
      echo
      echo "Alternatively, generate a configuration YAML file with the app wta-config and pass it as argument."
      echo
      echo "Make sure:
    - fastq file pairs contain a _R1_ or a _R2_ and have the same prefix
    - fastq headers follow this format: @READNAME [12]:N:0:SAMPLE_BARCODE
    - there is enough space in /tmp; if not, run with SINGULARITYENV_TMPDIR=path/to/some/directory singularity run ... (make sure the path is bound)
    - reference genome is a tar.gz STAR index
    - transcriptome annotation is a gtf file
    - quote strings in configuration YAML file"
      echo
      echo "This app will try to run jobs in parallel"
      echo 
    else
      echo "# cwl-runner --parallel --no-container --outdir . /cwl/v1.9.1/rhapsody_wta_1.9.1.cwl $@"
      cwl-runner --parallel --no-container --outdir . /cwl/v1.9.1/rhapsody_wta_1.9.1.cwl $@
    fi
    echo 

###################################

# BD Rhapsody Targeted pipeline   #

###################################

%apphelp targeted-config
    Generates a configuration YAML file for the targeted app.
    
%apprun targeted-config
    echo "Generating a configuration YAML for the targeted app"
    cp /cwl/v1.9.1/template_targeted_1.9.1.yml .

%apphelp targeted
    Run the app without arguments to see available options.
    
%apprun targeted
    echo "Running the BD Rhapsody Targeted Analysis pipeline"
    if [ $# -eq 0 ]
    then
      cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_targeted_1.9.1.cwl --help
      echo
      echo "Alternatively, generate a configuration YAML file with the app targeted-config and pass it as argument."
      echo
      echo "Make sure:
    - fastq file pairs contain a _R1_ or a _R2_ and have the same prefix
    - fastq headers follow this format: @READNAME [12]:N:0:SAMPLE_BARCODE
    - there is enough space in /tmp; if not, run with SINGULARITYENV_TMPDIR=path/to/some/directory singularity run ... (make sure the path is bound)
    - quote strings in configuration YAML file"
      echo
    else
      echo "# cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_targeted_1.9.1.cwl $@"
      cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_targeted_1.9.1.cwl $@
    fi
    echo
    
%apphelp targeted-parallel
    Run the app without arguments to see available options. This app will run jobs in parallel.
    
%apprun targeted-parallel
    echo "Running the BD Rhapsody Targeted Analysis pipeline"
    if [ $# -eq 0 ]
    then
      cwl-runner --no-container --outdir . /cwl/v1.9.1/rhapsody_targeted_1.9.1.cwl --help
      echo
      echo "Alternatively, generate a configuration YAML file with the app targeted-config and pass it as argument."
      echo
      echo "Make sure:
    - fastq file pairs contain a _R1_ or a _R2_ and have the same prefix
    - fastq headers follow this format: @READNAME [12]:N:0:SAMPLE_BARCODE
    - there is enough space in /tmp; if not, run with SINGULARITYENV_TMPDIR=path/to/some/directory singularity run ... (make sure the path is bound)
    - quote strings in configuration YAML file"
      echo
    else
      echo "# cwl-runner --parallel --no-container --outdir . /cwl/v1.9.1/rhapsody_targeted_1.9.1.cwl $@"
      cwl-runner --parallel --no-container --outdir . /cwl/v1.9.1/rhapsody_targeted_1.9.1.cwl $@
    fi
    echo
