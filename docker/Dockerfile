ARG GITHUB_TOKEN
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /home/pi/src
RUN mkdir -p /home/pi/build
COPY . /home/pi/src
WORKDIR /home/pi/src

# apt installs
RUN apt-get update && apt-get install -y -qq --no-install-recommends  \
    `cat /home/pi/src/dependencies/apt.txt`\
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove \
    && apt-get clean

# pip installs
RUN python3 -m pip install --no-cache-dir -r /home/pi/src/dependencies/pip.txt

# install Arduino CLI @todo probably separate this to a different container
RUN wget -O arduino-cli.tar.bz2 https://downloads.arduino.cc/arduino-cli/arduino-cli-latest-linux64.tar.bz2 && \
    tar -xf arduino-cli.tar.bz2 && \
    mv arduino-cli /usr/local/bin/arduino-cli && \
    rm arduino-cli.tar.bz2
RUN arduino-cli config init && \
    arduino-cli core update-index \
RUN arduino-cli core install esp32:esp32

# get piranha repo
RUN git clone https://${GITHUB_TOKEN}@github.com/Geurto/piranha.git

# install rust
RUN curl --proto '=https' --tlsv1.2 -sSfy https://sh.rustup.rs | sh
