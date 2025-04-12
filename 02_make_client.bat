REM ==== Client Zertifikat erstellen ====
openssl genrsa -out client.key 2048
openssl req -new -key client.key -out client.csr -config client-openssl.cnf

REM Client-Zertifikat signieren mit Intermediate
openssl x509 -req -in client.csr -CA ca\intermediate\intermediate-ca.crt -CAkey ca\intermediate\intermediate-ca.key -set_serial 101 -days 365 -out client.crt -extensions v3_req -extfile client-openssl.cnf

REM In PEM Format konvertieren
openssl x509 -in client.crt -out client.crt.pem -outform PEM

REM Generate public key
openssl x509 -in client.crt.pem -pubkey -noout > client.pubkey.pem

REM Sign a file
openssl dgst -sha256 -sign client.key -out example.sig example.exe

REM Check signature
openssl dgst -sha256 -verify client.pubkey.pem -signature example.sig openssl.exe
