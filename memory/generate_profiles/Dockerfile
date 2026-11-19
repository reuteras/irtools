FROM ubuntu:25.10@sha256:7cc5e35f6567ee8c66d2abb4aab0fd866669e6207c237c3a8f0947a5c7f17092

WORKDIR /

COPY build.sh .

# hadolint ignore=DL3003,DL3008,DL3027
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
    go install && \
    rm -rf /var/lib/apt/lists

COPY extract-vmlinux.sh .

RUN useradd --create-home --uid 10001 --shell /bin/bash profiles
USER 10001

HEALTHCHECK CMD ["test", "-x", "/extract-vmlinux.sh"]

CMD [ "/bin/bash" ]
