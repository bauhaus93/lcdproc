#!/bin/sh

if [ ! -d libelektra ]; then
	echo "error: lcdproc must be a direct subdirectory of the working directory!"
	exit 1
fi
if [ ! -d lcdproc ]; then
	echo "error: lcdproc must be a direct subdirectory of the working directory!"
	exit 1
fi

mkdir -p build-jenkins && \
cd build-jenkins &&
cmake \
	-DPLUGINS='MAINTAINED;toml' \
	../libelektra && \
make -j8 && \
sudo make -j8 install && \
cd ../lcdproc && \
sh ./autogen.sh && \
./configure && \
make && \
sudo make install && \
sudo ldconfig && \
./post-install.sh && \
cd .. && \
mkdir -p .config && \
cp lcdproc/LCDd.toml .config/LCDd.toml && \
cp lcdproc/lcdproc.toml .config/lcdproc.toml && \
cp lcdproc/lcdexec.toml .config/lcdexec.toml && \
cp lcdproc/lcdvc.toml .config/lcdvc.toml && \
echo "SUCCESS!"
