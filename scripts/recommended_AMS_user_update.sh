echo "Installation of sky130 open source PDK will begin..."

echo "You will need root permissions to perform tools installation..."

if [[ $EUID -ne 1000 ]]; then
   echo "This script must be run as user"
   exit 1
fi

export TOOLS_DIR=/edatools
#export TOOLS_DIR=/tools
export PDK_ROOT=$TOOLS_DIR/pdks

echo "Creating sky130_skel..."
cd ~
mkdir sky130_skel
cd sky130_skel
 
echo "Preparing libraries for AMS flow using XSchem..."

echo "Cloning XSchem_sky130 repo..."
git clone https://github.com/StefanSchippers/xschem_sky130.git

echo "Setting up sky130 libraries..."
cd $TOOLS_DIR/pdks/skywater-pdk/libraries
sudo cp -r sky130_fd_pr sky130_fd_pr_ngspice
cd sky130_fd_pr_ngspice/latest
sudo patch -p2 < ~/sky130_skel/xschem_sky130/sky130_fd_pr.patch

echo "Setting up magic ambient config..."
cd ~/sky130_skel
cp $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc .magicrc
#wget https://raw.githubusercontent.com/britovski/sky130_skel/main/.magicrc

echo "Setting up spice ambient area config with multi finger transistor compatibility..."
cat >> .spiceinit << 'END'
set ngbehavior=hs
END

cd xschem_sky130

cat >> .spiceinit << 'END'
set ngbehavior=hs
END


echo "#####################################################################################################################"
echo "To complete the workarea setup you need to update the last two lines of the file 'xschemrc' with the following paths:"
echo "set SKYWATER_MODELS $TOOLS_DIR/pdks/skywater-pdk/libraries/sky130_fd_pr_ngspice/latest"
echo "set SKYWATER_STDCELLS $TOOLS_DIR/pdks/skywater-pdk/libraries/sky130_fd_sc_hd/latest"
echo "#####################################################################################################################"

echo "Recommended sky130_skel for AMS flow update done!"
