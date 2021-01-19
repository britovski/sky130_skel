echo "Digital Workarea setup will begin..."

if [[ $EUID -ne 1000 ]]; then
   echo "This script must be run as user"
   exit 1
fi

echo "Entering sky130_skel..."

cd ~/sky130_skel

echo "Preparing libraries for Qflow/VSDSynth based Digital flow..."

echo "Cloning vsdflow repo..."

git clone https://www.github.com/kunalg123/vsdflow.git
cd vsdflow

echo "Testing VSDflow..."
./vsdflow spi_slave_design_details.csv

#################################
#### Test the VSDFlow with: #####
#################################
#### cd outdir_spi_slave ########
#### qflow display spi_slave ####
#################################

echo "User script for VSDFlow test workarea done!"
