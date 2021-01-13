echo "Installation of sky130 open source PDK with Open_PDKs manager focused on Openlane RTL2GDS Adanced Digital Flow will begin..."

echo "Is supposed that you have installed 'mininal_opentools.sh' previously!"

#echo "You will need root permissions to perform tools installation..."

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "Creating pdks directory..."

cd /
mkdir edatools
cd edatools
#mkdir tools
#cd tools
mkdir pdks
cd pdks

export PDK_ROOT=/edatools/pdks
#export PDK_ROOT=/tools/pdks

echo "Resolving dependencies..."
yum update -y
yum upgrade -y
yum install yum-utils device-mapper-persistent-data lvm2 git -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum list docker-ce --showduplicates
yum install docker-ce*19.03.12 -y

echo "Cloning sky130 libraries..."
git clone https://github.com/google/skywater-pdk
cd skywater-pdk
git submodule init libraries/sky130_fd_io/latest
git submodule init libraries/sky130_fd_pr/latest
git submodule init libraries/sky130_fd_sc_hd/latest
git submodule init libraries/sky130_fd_sc_hdll/latest
git submodule init libraries/sky130_fd_sc_hs/latest
git submodule init libraries/sky130_fd_sc_ms/latest
git submodule init libraries/sky130_fd_sc_ls/latest
git submodule init libraries/sky130_fd_sc_lp/latest
git submodule init libraries/sky130_fd_sc_hvl/latest
git submodule update
make timing 

cd ..

echo "Cloning Open_PDKs tool and setting up for tool flow compatibility..."
git clone https://github.com/RTimothyEdwards/open_pdks.git
cd open_pdks
git checkout 32cdb2097fd9a629c91e8ea33e1f6de08ab25946
./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-sky130-local-path=$PDK_ROOT
cd sky130
make
make install-local

#git clone git://opencircuitdesign.com/open_pdks
#cd open_pdks
#git checkout open_pdks-1.0
#./configure --enable-sky130-pdk=$TOOLS_DIR/pdks/skywater-pdk/libraries --with-sky130-local-path=$TOOLS_DIR/pdks
#cd sky130
#make
#make install

echo "You need to run 'openlane_user_install.sh' as user to complete setup"

echo "Done!"
