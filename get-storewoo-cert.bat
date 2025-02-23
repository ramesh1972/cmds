@echo off
:: Ensure proper line endings in Windows
setlocal enabledelayedexpansion

:: Set the hostname and port
set "HOSTNAME_PORT=store-woo.free.nf:443"

:: Set the alias for the key in the Java keystore
set "MY_KEY_ALIAS=store-woo-self-signed-cert"

:: Extract the certificate using OpenSSL
openssl s_client -showcerts -connect %HOSTNAME_PORT% <nul 2>nul | openssl x509 -outform PEM > mycertfile.pem

:: Import the certificate into Java keystore
:: Make sure to adjust JAVA_HOME if it's not set correctly

:: Import the certificate into the keystore (requires admin privileges)
echo changeit | keytool -trustcacerts -cacerts -storepass changeit -importcert -alias %MY_KEY_ALIAS% -file mycertfile.pem -noprompt

echo Certificate imported successfully.
