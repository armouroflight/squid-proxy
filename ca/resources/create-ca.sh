cd /ca
PASSWORD=tomTODOit
SUBJ="/C=GB/ST=Cardiff/L=Cardiff/O=Test/OU=Test/CN=Squid Proxy CA"
#openssl genrsa -out squidCA.key 2048 -passout pass:$PASSWORD -passin pass:$PASSWORD

# Create CA with private key
openssl req -x509 -new -nodes -keyout squidCA.key -sha256 -days 365 -out squidCA.pem \
-subj "${SUBJ}"
# Create DER encoded trusted cert
openssl x509 -in squidCA.pem -outform DER -out squidCA.der

# Generating dhparam files can take time
# We don't do this every time - especially in dev
if [ -f bump_dhparam.pem ]; then
    echo "Using existing dhparam"
else
    echo "Generate dhparam"
    openssl dhparam -outform PEM -out bump_dhparam.pem 2048
fi
