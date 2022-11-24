FROM alpine:3.7

ENV SQUID_LOG=/var/log/squid \
    SQUID_CACHE=/var/spool/squid \
    SQUID_PID=/var/run/squid.pid \
    SQUID_USER=squid

# Install squid
RUN apk add --no-cache squid openssl ca-certificates && update-ca-certificates

COPY ca/squidCA.* /
COPY ca/bump_dhparam.pem /

COPY resources/squid.conf /etc/squid/squid.conf

# Setup Squid SSL Bumping aka SSL aware aka TLS intercepting ...
# Squid SSL DB
RUN mkdir -p /var/lib/squid \
     && /usr/lib/squid/ssl_crtd -c -s /var/lib/squid/ssl_db \
     && chown -R squid:squid /var/lib/squid/

# Init logs
RUN mkdir -p ${SQUID_LOG} \
     && chmod -R 755 ${SQUID_LOG} \
     && chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_LOG}

# Init cache using -z
RUN mkdir -p ${SQUID_CACHE} \
     && chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_CACHE} \
     && squid -N -z

RUN mkdir -p /var/run/squid \
     && touch ${SQUID_PID} \
     && chmod -R u+rw ${SQUID_PID} \
     && chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_PID}

# USER ${SQUID_USER} - not required as squid forks as squid user

CMD ["squid", "-NYC"]
