FROM debian:13
ARG APT_PROXY
# Make apt proxy optional; pass --build-arg APT_PROXY=http://host:port when needed
RUN if [ -n "$APT_PROXY" ]; then echo "Acquire::http { Proxy \"$APT_PROXY\"; };" > /etc/apt/apt.conf.d/02proxy; fi
RUN apt update  && apt install -y \
    procps \
    iproute2 \
    iputils-ping \
    bind9 \
    bind9utils \
    dnsutils \
    rsyslog \
    && rm -rf /var/lib/apt/lists/*

# COPY named.conf.options /etc/bind/named.conf.options
RUN mkdir -p /dns
COPY entrypoint.sh /dns
RUN chmod a+x /dns/entrypoint.sh
EXPOSE 53
# USER bind
WORKDIR /var/cache/bind


RUN sed -i 's/^\s*module(load="imklog")/#module(load="imklog")/' /etc/rsyslog.conf
RUN mkdir -p /run/named && chmod 775 /run/named && chgrp bind /run/named

CMD ["-g","-4"]

ENTRYPOINT ["/dns/entrypoint.sh"]
