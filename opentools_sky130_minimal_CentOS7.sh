echo "Installation of EDA open source tools and minimal configuration to use sky130 open PDK will begin..."

echo "root permission is required for tools installation"

su -

echo "Setting up directories..."

cd /
mkdir edatools 
cd edatools
#mkdir tools
#cd tools
mkdir opentools
cd opentools

echo "Solving dependencies..."
yum update -y
yum upgrade -y
yum instal gcc gcc-c++ autoconf automake patch patchutils indent libtool python3 cmake -y
yum install mesa-libGL mesa-libGLU mesa-libGLU-devel libXp libXp-devel libXmu-devel tcl tk tcl-devel tk-devel cairo cairo-devel -y
yum install graphviz libXaw-devel readline-devel flex bison -y
#yum install openmpi openmpi-devel openmpi3 openmpi-devel3 -y #use if you want multi-core support

echo "Downloading tools..."
wget -O ngspice-33.tar.gz https://sourceforge.net/projects/ngspice/files/ng-spice-rework/33/ngspice-33.tar.gz/download
wget -O adms-2.3.6.tar.gz https://sourceforge.net/projects/mot-adms/files/adms-source/2.3/adms-2.3.6.tar.gz/download
wget http://opencircuitdesign.com/magic/archive/magic-8.3.113.tgz
wget http://opencircuitdesign.com/netgen/archive/netgen-1.5.162.tgz
 
echo "Installing tools..."

echo "Installing Ngspice with ADMS and XSPICE support..."
tar zxvpf adms-2.3.6.tar.gz
cd adms-2.3.6.tar.gz
./configure
make
make install
cd ..

tar zxvpf ngspice-33.tar.gz
cd ngspice-33
wget -O ng_adms_va.tar.gz https://sourceforge.net/projects/ngspice/files/ng-spice-rework/33/ng_adms_va.tar.gz/download
tar zxvpf ng_adms_va.tar.gz
./autogen.sh --adms
mkdir release
cd release
#../configure --with-x --enable-xspice --enable-cider --enable-openmp --with-readlines=yes --disable-debug --enable-adms #use if you want multi-core support
../configure --with-x --enable-xspice --enable-cider --with-readlines=yes --disable-debug --enable-adms CFLAGS=-std=c99
make -j$(nproc) CFLAGS=-std=c99
make install

cd ../../

echo "Installing Magic Layout..."
tar zxvpf magic-8.3.11.113.tgz
cd magic-8.3.11.113
./configure
make
make install

cd ..

echo "Installing Netgen..."
tar zxvpf netgen-1.5.162.tgz
cd netgen-1.5.162
./configure
make
make install

cd ..

exit

echo "Setting up minimal workarea"
cd ~
mkdir sky130_skel
cd sky130_skel
wget https://www.github.com/britovski/sky130_skel/minimal_libs.tgz
tar zxvpf minimal_libs.tgz

echo "Minimal configuration for EDA open source tools and sky130 open PDK done!"
