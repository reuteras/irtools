# hadolint ignore=DL3007
FROM debian:latest
WORKDIR /opt
# hadolint ignore=DL3003,DL3027
RUN apt update && \
    apt -y dist-upgrade && \
    apt -y install git python-is-python3 python3-pip libssl-dev && \
    git clone https://github.com/Neo23x0/Loki.git && \
    cd Loki && \
    chmod a+x loki.py && \
    python3 -m pip install --no-cache-dir -r requirements.txt && \
    git clone https://github.com/Neo23x0/signature-base.git && \
    apt-get auto-remove -qqy git apt-transport-https python3-pip python3-setuptools python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc && \
    rm -rf /usr/local/share/man /var/cache/debconf/*-old && \
    rm -rf /opt/Loki/.git*
#ENTRYPOINT [ "/usr/bin/python3", "/opt/Loki/loki.py" ]
CMD ["--help"]
