@echo off

REM ==== Intermediate CA erstellen ====
openssl genrsa -out ca\intermediate\intermediate-ca.key 2048
openssl req -new -key ca\intermediate\intermediate-ca.key -out ca\intermediate\intermediate-ca.csr -config ca\intermediate\openssl.cnf

REM Intermediate CA signieren
openssl x509 -req -in ca\intermediate\intermediate-ca.csr -CA ca\root\root-ca.crt -CAkey ca\root\root-ca.key -set_serial 100 -days 3650 -out ca\intermediate\intermediate-ca.crt -extensions v3_ca -extfile ca\intermediate\openssl.cnf

copy ca\intermediate\intermediate-ca.crt ca\intermediate\intermediate-ca.cer
openssl x509 -in ca\intermediate\intermediate-ca.crt -outform DER -out ca\intermediate\intermediate-ca.der
type ca\intermediate\intermediate-ca.key ca\intermediate\intermediate-ca.crt > ca\intermediate\intermediate-ca.pem
