FROM alpine:3.3
MAINTAINER Elton Renda "https://github.com/ej52"

# Add s6-overlay and go_dnsmasq
ENV S6_OVERLAY_VERSION=v1.17.1.1 GODNSMASQ_VERSION=0.9.8

RUN apk --no-cache add bind-tools curl && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz \
    | tar xvfz - -C / && \
    curl -sSL https://github.com/janeczku/go-dnsmasq/releases/download/${GODNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 -o /bin/go-dnsmasq && \
    chmod +x /bin/go-dnsmasq && \
    apk del curl && \
    rm -rf /var/cache/apk/*

ADD root /

ENTRYPOINT ["/init"]
CMD []
