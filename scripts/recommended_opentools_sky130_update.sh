echo "Installation 'UPDATE' of EDA open source tools for recommended AMS configuration and sky130 open PDK will begin..."
echo "For this script it is assumed that you previously ran 'minimal_opentools.sh'"
echo "You will need root permissions to perform tools installation..."

# Ensure script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Entering directories..."
mkdir -p /edatools/opentools
cd /edatools/opentools

echo "Resolving dependencies..."
yum install ruby qt-x11 gtk3-devel -y
if [ $? -ne 0 ]; then
    echo "Failed to install dependencies. Exiting..."
    exit 1
fi

echo "Downloading additional tools..."
if [ ! -d "xschem" ]; then
    git clone https://github.com/StefanSchippers/xschem
else
    echo "XSchem directory already exists, skipping clone..."
fi

wget https://www.klayout.org/downloads/CentOS_7/klayout-0.28.17-0.x86_64.rpm
if [ ! -f "klayout-0.28.17-0.x86_64.rpm" ]; then
    echo "Failed to download KLayout."
    exit 1
fi

wget https://github.com/edneymatheus/gaw3-20220315/raw/main/gaw3-20220315.tar.gz -O gaw3-20220315.tar.gz
if [ ! -f "gaw3-20220315.tar.gz" ]; then
    echo "Failed to download GAW."
    exit 1
fi

echo "Installing tools..."

echo "Installing XSchem..."
cd xschem
./configure
make
make install
if [ $? -ne 0 ]; then
    echo "Failed to install XSchem."
    exit 1
fi
cd ..

echo "Installing gaw..."
tar zxvpf gaw3-20220315.tar.gz
cd gaw3-20220315
./configure
make
make install
if [ $? -ne 0 ]; then
    echo "Failed to install GAW."
    exit 1
fi
cd ..

echo "Installing KLayout..."
yum localinstall klayout-0.28.17-0.x86_64.rpm -y
if [ $? -ne 0 ]; then
    echo "Failed to install KLayout."
    exit 1
fi

echo "Creating pdks directory..."
export TOOLS_DIR=/edatools
export PDK_ROOT=$TOOLS_DIR/pdks
mkdir -p $PDK_ROOT

echo "Cloning sky130 libraries..."
cd $PDK_ROOT
if [ ! -d "skywater-pdk" ]; then
    git clone https://github.com/google/skywater-pdk
    cd skywater-pdk
    git submodule init libraries/sky130_fd_pr/latest
    git submodule init libraries/sky130_fd_sc_hd/latest
    git submodule update
    cd ..
else
    echo "skywater-pdk directory already exists, skipping clone..."
fi

echo "Cloning Open_PDKs tool and setting up for tool flow compatibility..."
if [ ! -d "open_pdks" ]; then
    git clone https://github.com/RTimothyEdwards/open_pdks.git
    cd open_pdks
    git checkout 32cdb2097fd9a629c91e8ea33e1f6de08ab25946
    ./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-sky130-local-path=$PDK_ROOT
    cd sky130
    make
    make install-local
    cd ..
else
    echo "Open_PDKs directory already exists, skipping clone..."
fi

echo "Installation process completed. Checking installations..."

# Verification of installations
which xschem && echo "XSchem installed successfully." || echo "XSchem installation failed."
which klayout && echo "KLayout installed successfully." || echo "KLayout installation failed."
[ -d "$PDK_ROOT/skywater-pdk" ] && echo "Skywater PDK cloned successfully." || echo "Skywater PDK cloning failed."
[ -d "$PDK_ROOT/open_pdks" ] && echo "Open_PDKs cloned and set up successfully." || echo "Open_PDKs setup failed."

echo "Recommended EDA open source tools update and sky130 open PDK AMS installation done!"
echo "Run the 'recommended_AMS_user_update.sh' for user sky130_skel update."