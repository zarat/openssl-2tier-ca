@echo off

REM ==== Root CA erstellen ====
openssl req -newkey rsa:2048 -nodes -keyout ca\root\root-ca.key -x509 -days 3650 -out ca\root\root-ca.crt -config ca\root\openssl.cnf
