FROM debian:13
ARG APT_PROXY
# Make apt proxy optional; pass --build-arg APT_PROXY=http://host:port when needed
RUN if [ -n "$APT_PROXY" ]; then echo "Acquire::http { Proxy \"$APT_PROXY\"; };" > /etc/apt/apt.conf.d/02proxy; fi
RUN apt update  && apt install -y \
    procps \
    iproute2 \
    iputils-ping \
    bind9utils \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*


CMD ["tail", "-f", "/dev/null"]
