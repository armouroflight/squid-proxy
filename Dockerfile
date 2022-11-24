FROM alpine:3.7

# Install squid
RUN apk add --no-cache squid openssl ca-certificates && update-ca-certificates

COPY ca/squidCA.* /

# Setup Squid SSL Bumping aka SSL aware aka TLS intercepting ...
# Squid SSL DB
RUN mkdir -p /var/lib/squid \
     && /usr/lib/squid/ssl_crtd -c -s /var/lib/squid/ssl_db \
     && chown -R squid:squid /var/lib/squid/

