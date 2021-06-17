echo "Installation "UPDATE" of EDA open source tools for recommended AMS configuration and sky130 open PDK will begin..."

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
yum install gtk3-devel -y

echo "Downloading additional tools..."
git clone https://github.com/StefanSchippers/xschem
wget https://www.klayout.org/downloads/CentOS_7/klayout-0.26.9-0.x86_64.rpm
wget http://download.tuxfamily.org/gaw/download/gaw3-20200922.tar.gz

echo "Installing tools..."

echo "Installing XSchem..."

cd xschem
./configure
make
make install
cd ..

echo "Installing gaw"
tar zxvpf gaw3-20200922.tar.gz
cd gaw3-20200922
./configure
make
make install
cd ..

echo "Installing KLayout..."
rpm -ivh klayout-0.26.9-0.x86_64.rpm
cd ..

echo "Creating pdks directory..."
mkdir pdks
cd pdks

export TOOLS_DIR=/edatools
#export TOOLS_DIR=/tools
export PDK_ROOT=$TOOLS_DIR/pdks

echo "Cloning sky130 libraries..."
git clone https://github.com/google/skywater-pdk
cd skywater-pdk
#git submodule init libraries/sky130_fd_io/latest #uncomment for openlane flow
git submodule init libraries/sky130_fd_pr/latest
git submodule init libraries/sky130_fd_sc_hd/latest
#git submodule init libraries/sky130_fd_sc_hdll/latest
#git submodule init libraries/sky130_fd_sc_hs/latest
#git submodule init libraries/sky130_fd_sc_ms/latest
#git submodule init libraries/sky130_fd_sc_ls/latest
#git submodule init libraries/sky130_fd_sc_lp/latest
#git submodule init libraries/sky130_fd_sc_hvl/latest #uncomment for openlane flow
git submodule update
#make timing #uncomment just for digital/openlane flow

cd ..

echo "Cloning Open_PDKs tool and setting up for tool flow compatibility..."
git clone https://github.com/RTimothyEdwards/open_pdks.git
cd open_pdks
git checkout 32cdb2097fd9a629c91e8ea33e1f6de08ab25946
./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-sky130-local-path=$PDK_ROOT
cd sky130
make
make install-local

echo "Recommended EDA open source tools update and sky130 open PDK AMS installation done!"
echo "Run the 'recommended_AMS_user_update.sh' for user sky130_skel update."
