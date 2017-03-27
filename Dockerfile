FROM alpine:3.4
MAINTAINER Elton Renda "https://github.com/ej52"

# Add s6-overlay and go_dnsmasq
ENV S6_OVERLAY_VERSION=v1.19.1.1 \
    GODNSMASQ_VERSION=1.0.7

RUN apk add --no-cache bind-tools curl && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz \
    | tar xfz - -C / && \
    curl -sSL https://github.com/janeczku/go-dnsmasq/releases/download/${GODNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 -o /bin/go-dnsmasq && \
    chmod +x /bin/go-dnsmasq && \
    apk del curl && \
    rm -rf /var/cache/apk/* && \

    # create user and give binary permissions to bind to lower port
    addgroup go-dnsmasq && \
    adduser -D -g "" -s /bin/sh -G go-dnsmasq go-dnsmasq && \
    setcap CAP_NET_BIND_SERVICE=+eip /bin/go-dnsmasq

ADD root /

ENTRYPOINT ["/init"]
CMD []
