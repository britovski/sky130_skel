echo "Installation of RF EDA open source tools to use sky130 open PDK will begin..."

echo "For this script is supposed that you previously run 'minimal_opentools.sh'"

#echo "You will need root permissions to perform tools installation..."


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "Entering directories..."

cd /edatools/opentools

echo "Solving dependencies and downloading sources..."

yum install qt qt-devel ruby qperf -y
yum remove wine -y
yum -y install https://harbottle.gitlab.io/wine32/7/i386/wine32-release.rpm
yum -y install wine.i686

echo "Downloading RF tools..."
wget http://dd6um.darc.de/QucsStudio/QucsStudio-3.3.2.zip
wget -O qucs-0.0.18.tar.gz https://sourceforge.net/projects/qucs/files/qucs/0.0.18/qucs-0.0.18.tar.gz/download
wget https://xyce.sandia.gov/downloads/_assets/documents/Binaries/Install_Xyce_Release7.2.0_Intel64_RHEL7_Serial-icc_opensource.rpm
wget http://download.opensuse.org/repositories/home:/ra3xdh/CentOS_7/x86_64/qucs-s-0.0.22-4.3.x86_64.rpm
#asitic docker
#OpenEMS

echo "Installing tools..."

echo "Installing Qucs base..."

tar zxvpf qucs-0.0.18.tar.gz
cd qucs-0.0.18
./configure
make
make install
cd ..

echo "Installing QucsStudio..."

unzip QucsStudio-3.3.2.zip

echo "Installing Xyce..."

rpm -ivh Install_Xyce_Release7.2.0_Intel64_RHEL7_Serial-icc_opensource.rpm
ln -s /usr/local/Xyce-Release-7.2.0-OPENSOURCE/bin/Xyce /usr/local/bin/Xyce

echo "Installing Qucs-S..."

rpm -ivh qucs-s-0.0.22-4.3.x86_64.rpm

#echo "Installing OpenEMS..."


echo "RF EDA open source tools installation done!"
echo "Run the 'rf_user_install.sh' script for RF workarea setup"
