Bootstrap: docker
From: python:3.9-slim-buster

%files
    # Copy everything in the current directory into /app in the container.
    # (You may want to use a .singularity.dignore file to exclude files not needed in the container.)
    . /app

%post
    echo "Installing system dependencies..."
    apt-get update && apt-get install -y \
        build-essential \
        libxml2-dev \
        libz-dev \
        pkg-config \
        zip && rm -rf /var/lib/apt/lists/*

    echo "Changing to /app directory..."
    cd /app

    echo "Upgrading pip and installing Python dependencies..."
    pip install --upgrade pip
    pip install -r requirements.txt

    echo "Making entrypoint.sh executable..."
    chmod +x /app/entrypoint.sh

%environment
    # Set any environment variables you need; here we export APP_HOME
    export APP_HOME=/app

%runscript
    # This runscript executes when you run the container.
    # It’s equivalent to Docker’s CMD.
    exec /app/entrypoint.sh "$@"
