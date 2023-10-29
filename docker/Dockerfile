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

# install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN echo "export PATH=/root/.cargo/bin:${PATH}" >> /root/.bashrc

# build core code
RUN cd core && cargo build --release
