echo "Installation "UPDATE" of EDA open source tools for recommended AMS configuration to use sky130 open PDK will begin..."

echo "For this script is supposed that you previously run 'minimal_opentools.sh'"

#echo "You will need root permissions to perform tools installation..."


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "Entering directories..."

cd /edatools
#cd /tools
cd opentools

echo "Resolving dependencies..."
yum install ruby qt-x11 -y

echo "Downloading additional tools..."
git clone https://github.com/StefanSchippers/xschem
wget https://www.klayout.org/downloads/CentOS_7/klayout-0.26.9-0.x86_64.rpm

echo "Installing tools..."

echo "Installing XSchem..."

cd xschem
./configure
make
make install
cd ..

echo "Installing KLayout..."
rpm -ivh klayout-0.26.9-0.x86_64.rpm

echo "Recommended EDA open source tools installation update done!"
echo "Run the 'recommended_sky130_pdk_install.sh' script for PDK installation"
