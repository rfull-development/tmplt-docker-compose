# Copyright (c) 2023 RFull Development
# This source code is managed under the MIT license. See LICENSE in the project root.
# Download and expand package
curl -o openssl-1.1.1u.tar.gz -L https://www.openssl.org/source/openssl-1.1.1u.tar.gz
tar xzf openssl-1.1.1u.tar.gz
rm -f openssl-1.1.1u.tar.gz

# Build package
cd ./openssl-1.1.1u
./config --prefix=/usr/local
make
sudo make install
cd ..
sudo rm -rf ./openssl-1.1.1u
export LD_LIBRARY_PATH=/usr/local/lib
