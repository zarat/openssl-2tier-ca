@echo off

REM ==== Root CA erstellen ====
openssl req -newkey rsa:2048 -nodes -keyout ca\root\root-ca.key -x509 -days 3650 -out ca\root\root-ca.crt -config ca\root\openssl.cnf

copy ca\root\root-ca.crt ca\root\root-ca.cer
openssl x509 -in ca\root\root-ca.crt -outform DER -out ca\root\root-ca.der
type ca\root\root-ca.key ca\root\root-ca.crt > ca\root\root-ca.pem
