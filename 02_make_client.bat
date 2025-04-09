REM ==== Client Zertifikat erstellen ====
openssl genrsa -out client.key 2048
openssl req -new -key client.key -out client.csr -config client-openssl.cnf

REM Client-Zertifikat signieren mit Intermediate
openssl x509 -req -in client.csr -CA ca\intermediate\intermediate-ca.crt -CAkey ca\intermediate\intermediate-ca.key -set_serial 101 -days 365 -out client.crt -extensions v3_req -extfile client-openssl.cnf

REM In PEM Format konvertieren
openssl x509 -in client.crt -out client.crt.pem -outform PEM