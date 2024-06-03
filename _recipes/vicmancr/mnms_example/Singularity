Bootstrap: docker
From: tensorflow/tensorflow:1.12.3-gpu-py3

%files
    # The pattern is: "<source_path> <destination_path>"
    # The destination path is created automatically if it does not exist
    # Step 1: 
    #   - Copy requirements file if needed
    requirements.txt requirements.txt
    #   - Copy model files (including model weights and metadata files)
    segmentation_model/* mnms/

%post
    apt-get -y update
    # Step 2:
    #   - Install dependencies needed for you particular requirements
    #     (in this case, these are needed for opencv-python)
    apt-get install -y libsm6 libxext6 libxrender-dev
    #   - Install your requirements
    pip install -r requirements.txt

%runscript
    echo "tensorflow container"
    echo

    # Step 3:
    #   - Write the code that must be executed when run. Please, keep the "$@" at the end.
    #     This is intended for passing the arguments <input_data_folder_path> and <output_results_folder>.
    python /mnms/eval.py "$@"

%labels
    # Step 4: Build with "sudo singularity build wolf.sif Singularity" for the wolf team.
    Maintainer "Victor M. Campello"