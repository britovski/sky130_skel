echo "Installation and automated test of the Openlane RTL2GDS Adanced Digital Flow..."

#echo "Is supposed that you have installed 'mininal_opentools.sh' previously!"

#echo "You will need root permissions to perform installation..."

if [[ $EUID -ne 1000 ]]; then
   echo "This script must be run as user"
   exit 1
fi

export PDK_ROOT=/edatools/pdks
#export PDK_ROOT=/tools/pdks

echo "Creating sky130_skel..."
cd ~
mkdir sky130_skel
cd sky130_skel

echo "Running and configuring docker permissions..."
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -aG docker $USER
sudo setfacl --modify user:$USER:rw /var/run/docker.sock 

echo "Cloning openlane repo..."
git clone https://github.com/efabless/openlane.git --branch rc6

cd openlane/

echo "Building openlane local docker..."
make openlane
#make pdk

echo "Testing openlane..."
make test

echo "Done!"
