#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Install FIO and NMON
#--------------------------------------------------------------------------------------

# wget https://git.kernel.org/pub/scm/linux/kernel/git/axboe/fio.git/snapshot/fio-3.20.tar.gz
wget https://git.kernel.org/pub/scm/linux/kernel/git/axboe/fio.git/snapshot/fio-3.19.tar.gz
gunzip -c ./fio-3.19.tar.gz | tar -xvf - 
cd ./fio-3.19/
make clean
./configure --prefix=/usr/local
make clean
make
make install
cd ..
rm -rf ./fio-3.19.tar.gz ./fio-3.19/

wget http://sourceforge.net/projects/nmon/files/nmon16e_x86_rhel72 -O nmon
chmod 755 ./nmon
mv ./nmon /usr/local/bin/nmon


