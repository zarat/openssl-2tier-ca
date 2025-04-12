cd ca
cd root
del *.pem *.crt *.csr *.key *.cer *.der
cd ..
cd intermediate
del *.pem *.crt *.csr *.key *.cer *.der
cd ..
cd ..
rmdir /Q /S output
del *.sig
