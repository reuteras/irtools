FROM ubuntu:26.04@sha256:d66b366dac61b575bee2aef07e9c26e8070096fbe84a3d4d3eb0da069b5d76db

WORKDIR /

COPY build.sh .

# hadolint ignore=DL3003,DL3008,DL3027
RUN apt-get update --fix-missing && \
    apt-get upgrade -qqy && \
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
    go install && \
    rm -rf /var/lib/apt/lists

COPY extract-vmlinux.sh .

RUN useradd --create-home --uid 10001 --shell /bin/bash profiles
USER 10001

HEALTHCHECK CMD ["test", "-x", "/extract-vmlinux.sh"]

CMD [ "/bin/bash" ]
