Bootstrap: docker
From: node:8
Includecmd: no

%labels
Maintainer Matthew Andres Moreno
Version 0.3.0

################################################################################
# Copy Files Into the Container
################################################################################
%files
. /opt/nightmare-downloader

################################################################################
# Install Stuff
################################################################################
%post
apt-get update && apt-get install -yq gconf-service libasound2 \
    libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 \
    libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 \
    libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
    libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
    libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 \
    libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates \
    fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
    xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable \
    xfonts-cyrillic x11-apps clang libdbus-1-dev libgtk2.0-dev libnotify-dev \
    libgnome-keyring-dev libgconf2-dev libasound2-dev libcap-dev libcups2-dev \
    libxtst-dev libxss1 libnss3-dev gcc-multilib g++-multilib \
    wget curl && rm -r /var/lib/apt/lists/*

cd /opt/nightmare-downloader
npm install
chmod 777 -R /opt

################################################################################
# How to Run the Container
################################################################################
%runscript
cd /opt/nightmare-downloader
node serve-and-run.js "$@"

################################################################################
# Environment Stuff
################################################################################
%environment
NODE_ENV=development
PORT=9000
ALLOW_HTTP=true
URL=localhost
export NODE_ENV PORT ALLOW_HTTP URL
