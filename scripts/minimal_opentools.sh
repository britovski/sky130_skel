echo "Installation of EDA open source tools and minimal configuration to use sky130 open PDK will begin..."

#echo "You will need root permissions to perform tools installation..."


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

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
yum install gcc gcc-c++ autoconf automake patch patchutils indent libtool python3 cmake git -y
yum install mesa-libGL mesa-libGLU mesa-libGLU-devel libXp libXp-devel libXmu-devel tcl tk tcl-devel tk-devel cairo cairo-devel -y
yum install graphviz libXaw-devel readline-devel flex bison -y
#yum install openmpi openmpi-devel openmpi3 openmpi-devel3 -y #use if you want multi-core support

echo "Downloading tools..."
wget -O ngspice-33.tar.gz https://sourceforge.net/projects/ngspice/files/ng-spice-rework/old-releases/33/ngspice-33.tar.gz/download
wget -O adms-2.3.6.tar.gz https://sourceforge.net/projects/mot-adms/files/adms-source/2.3/adms-2.3.6.tar.gz/download
wget http://opencircuitdesign.com/magic/archive/magic-8.3.78.tgz
wget http://opencircuitdesign.com/netgen/archive/netgen-1.5.155.tgz
 
echo "Installing tools..."

echo "Installing Ngspice with ADMS and XSPICE support..."
tar zxvpf adms-2.3.6.tar.gz
cd adms-2.3.6
./configure
make
make install
cd ..

tar zxvpf ngspice-33.tar.gz
cd ngspice-33
wget -O ng_adms_va.tar.gz https://sourceforge.net/projects/ngspice/files/ng-spice-rework/old-releases/33/ng_adms_va.tar.gz/download
tar zxvpf ng_adms_va.tar.gz
./autogen.sh --adms
mkdir release
cd release
../configure --with-x --enable-xspice --disable-debug --enable-cider --with-readline=yes --enable-adms CFLAGS=-std=c99
make -j$(nproc) CFLAGS=-std=c99
make install
#../configure --with-x --enable-xspice --enable-cider --enable-openmp --with-readlines=yes --disable-debug --enable-adms #use if you want multi-core support

cd ../../

echo "Installing Magic Layout..."
tar zxvpf magic-8.3.78.tgz
cd magic-8.3.78
./configure
make
make install

cd ..

echo "Installing Netgen..."
tar zxvpf netgen-1.5.155.tgz
cd netgen-1.5.155
./configure
make
make install

echo "Minimal EDA open source tools installation done!"
echo "Back to user and run the 'minimal_sky130_skel.sh' script"
