# Create a Singularity definition file
Bootstrap: docker
From: python:3.9-slim

%post
    # Install system dependencies
    apt-get update && apt-get install -y
    pip3 install --upgrade pip

    # Add additional packages as needed
    pip3 install torch transformers pandas SentencePiece protobuf accelerate \
                 sentence-transformers langchain-community faiss-gpu tensorflow_hub \
                 scipy gensim tqdm joblib optimum auto-gptq tensorflow

%environment
    export LC
