cd /ca
PASSWORD=tomTODOit
#openssl genrsa -out squidCA.key 2048 -passout pass:$PASSWORD -passin pass:$PASSWORD

# Create CA with private key
openssl req -x509 -new -nodes -keyout squidCA.key -sha256 -days 365 -out squidCA.pem \
-subj "/C=GB/ST=Cardiff/L=Cardiff/O=Admiral/OU=Data Tribe/CN=Admiral Data Science Sandbox Squid Proxy CA"
# Create DER encoded trusted cert
openssl x509 -in squidCA.pem -outform DER -out squidCA.der
