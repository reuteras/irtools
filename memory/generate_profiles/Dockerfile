FROM ubuntu:22.04

WORKDIR /

COPY build.sh .

RUN apt-get update --fix-missing && \
    apt-get install -qqy --no-install-recommends \
        build-essential \
        ca-certificates \
        cpio \
        dwarfdump \
        git \
        golang-go \
        libelf-dev \
        rpm2cpio && \
    git clone https://github.com/volatilityfoundation/volatility.git && \
    git clone https://github.com/volatilityfoundation/dwarf2json && \
    cd /dwarf2json && \
    go build && \
    go install

COPY extract-vmlinux.sh .

CMD [ "/bin/bash" ]
