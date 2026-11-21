# Build dwarf2json with a current Go (static binary), so the image does not
# ship Ubuntu's older Go toolchain and its stdlib vulnerabilities.
FROM golang:1.27.4-trixie@sha256:f18c3d73a184fb0582828510722e723b63a93f7188d11dd223d9be6f6880e65d AS dwarf2json
# hadolint ignore=DL3003
RUN git clone https://github.com/volatilityfoundation/dwarf2json /src/dwarf2json && \
    cd /src/dwarf2json && \
    CGO_ENABLED=0 go build -o /out/dwarf2json .

FROM ubuntu:26.04@sha256:d66b366dac61b575bee2aef07e9c26e8070096fbe84a3d4d3eb0da069b5d76db

WORKDIR /

COPY build.sh .

# /usr/bin/pebble (Ubuntu's service manager, a Go binary with stdlib
# findings) is not used in this container, so it is removed.
# hadolint ignore=DL3008,DL3027
RUN apt-get update --fix-missing && \
    apt-get upgrade -qqy && \
    apt-get install -qqy --no-install-recommends \
        build-essential \
        ca-certificates \
        cpio \
        dwarfdump \
        git \
        libelf-dev \
        rpm2cpio && \
    git clone https://github.com/volatilityfoundation/volatility.git && \
    rm -rf /var/lib/apt/lists && \
    rm -f /usr/bin/pebble

# Same paths as before: /dwarf2json/dwarf2json, and dwarf2json on PATH.
COPY --from=dwarf2json /out/dwarf2json /dwarf2json/dwarf2json
COPY --from=dwarf2json /out/dwarf2json /usr/local/bin/dwarf2json

COPY extract-vmlinux.sh .

RUN useradd --create-home --uid 10001 --shell /bin/bash profiles
USER 10001

HEALTHCHECK CMD ["test", "-x", "/extract-vmlinux.sh"]

CMD [ "/bin/bash" ]
