echo "Installation of digital EDA open source tools flow..."

echo "For this script is supposed that you previously run 'minimal_opentools.sh' or recommended one"

#echo "You will need root permissions to perform tools installation..."


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "Entering directories..."

cd /edatools/
#cd /tools/
cd opentools

echo "Solving dependencies..."

#yum install -y https://centos7.iuscommunity.org/ius-release.rpm 
#yum update -y
yum install -y python3 python3-libs python3-devel python3-pip
#ln -s /usr/bin/python3.6 /usr/bin/python3
yum install gcc-gnat -y
yum install clang libffi-devel gsl-devel -y
yum install python3-tkinter -y
#yum installl cmake -y
yum install epel-release -y

wget "https://github.com/Kitware/CMake/releases/download/v3.13.0/cmake-3.13.0.tar.gz"
tar -xvzf cmake-3.13.0.tar.gz
cd cmake-3.13.0/
./bootstrap --prefix=/usr/local
make -j$(nproc)
make install
cd ..
#wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/t/tcllib-1.14-1.el7.noarch.rpm
#sudo rpm -Uvh tcllib-1.14-1.el7.noarch.rpm
#sudo yum install tcllib
yum install tcllib -y

echo "Downloading tools..."

wget -O ghdl-0.37.tar.gz https://github.com/ghdl/ghdl/archive/v0.37.tar.gz
wget https://github.com/YosysHQ/yosys/archive/yosys-0.9.tar.gz
wget -O graywolf-0.1.6.tar.gz https://github.com/rubund/graywolf/archive/0.1.6.tar.gz
wget http://opencircuitdesign.com/qrouter/archive/qrouter-1.4.83.tgz
wget http://opencircuitdesign.com/qflow/archive/qflow-1.4.90.tgz
wget -O OpenSTA-2.2.0.tar.gz https://github.com/The-OpenROAD-Project/OpenSTA/archive/v2.2.0.tar.gz

echo "Installing tools..."

echo "Installing GTKWave..."
yum install gtkwave -y

echo"Installing Icarus Verilog..."
yum install iverilog -y

echo "Installing GHDL..."
tar zxvpf ghdl-0.37.tar.gz
cd ghdl-0.37
./configure
make
make install
cd ..

echo "Installing Yosys..."
tar zxvpf yosys-0.9.tar.gz
cd yosys-yosys-0.9
make config-clang
make
make install
cd ..

echo "Installing Graywolf..."
tar zxvpf graywolf-0.1.6.tar.gz
cd graywolf-0.1.6
mkdir build
cd build
cmake ..
make
make install
cd ../../

echo "Installing qrouter..."
tar zxvpf qrouter-1.4.83.tgz
cd qrouter-1.4.83
./configure
make
make install
cd ..

echo "Installing qflow..."
tar zxvpf qflow-1.4.90.tgz
cd qflow-1.4.90
./configure
make
make install
cd ..

echo "Installing OpenSTA..."
tar zxvpf OpenSTA-2.2.0.tar.gz
cd OpenSTA-2.2.0
mkdir build
cd build
cmake ..
make
make install
cd ../../

echo "Digital tools installed!"
