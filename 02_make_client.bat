mkdir output

REM ==== Client Zertifikat erstellen ====
openssl genrsa -out output\client.key 2048
openssl req -new -key output\client.key -out output\client.csr -config client-openssl.cnf

REM Client-Zertifikat signieren mit Intermediate
openssl x509 -req -in output\client.csr -CA ca\intermediate\intermediate-ca.crt -CAkey ca\intermediate\intermediate-ca.key -set_serial 101 -days 365 -out output\client.crt -extensions v3_req -extfile client-openssl.cnf

REM In PEM Format konvertieren
openssl x509 -in output\client.crt -out output\client.crt.pem -outform PEM

REM In PEM Format konvertieren
openssl x509 -in output\client.crt -out output\client.crt.der -outform DER

REM Client Zertifikat erstellen
openssl pkcs12 -export -out output\client.p12 -inkey output\client.key -in output\client.crt -certfile ca\intermediate\intermediate-ca.crt
openssl pkcs12 -export -out output\client.pfx -inkey output\client.key -in output\client.crt -certfile ca\intermediate\intermediate-ca.crt

REM Private key in DER
openssl rsa -in output\client.key -out output\client.key.der -outform DER

REM pkcs7
openssl crl2pkcs7 -nocrl -certfile output\client.crt -out output\client.p7b

REM Full chain in PEM
type ca\root\root-ca.crt ca\intermediate\intermediate-ca.crt output\client.crt > output\client_chain.pem

REM Full chain in DER
openssl crl2pkcs7 -nocrl -certfile output\client_chain.pem -out output\client_chain.der -outform DER

REM Check 
openssl x509 -in output\client.crt -noout -text

REM Generate public key
openssl x509 -in output\client.crt.pem -pubkey -noout > output\client.pubkey.pem

REM Sign a file
openssl dgst -sha256 -sign output\client.key -out openssl.sig openssl.exe

REM Check signature
openssl dgst -sha256 -verify output\client.pubkey.pem -signature openssl.sig openssl.exe
