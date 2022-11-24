FROM alpine:3.7

RUN apk add --no-cache openssl

COPY resources/create-ca.sh /bin/
RUN chmod +x /bin/create-ca.sh

