# #!/bin/bash
# this will ensure proper line endings on .sh file running on windows
(set -o igncr) 2>/dev/null && set -o igncr; # this comment is needed

# HOSTNAME_PORT is the host that you want to connect to - example: HOSTNAME_PORT=stackoverflow.com:443
HOSTNAME_PORT=store-woo.free.nf

# whatever you want to call the key within the Java key store
MY_KEY_ALIAS=store-woo-self-signed-cert

openssl s_client -showcerts -connect $HOSTNAME_PORT </dev/null 2>/dev/null|openssl x509 -outform PEM >mycertfile.pem
sudo keytool -trustcacerts -keystore $JAVA_HOME/jre/lib/security/cacerts/pki/java/cacerts -storepass changeit -importcert -alias $MY_KEY_ALIAS -file mycert