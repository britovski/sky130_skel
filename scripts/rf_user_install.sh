echo "RF Workarea setup will begin..."

if [[ $EUID -ne 1000 ]]; then
   echo "This script must be run as user"
   exit 1
fi

echo "Entering sky130_skel..."

cd ~/sky130_skel

echo "Preparing libraries for RF flow using Qucs based tools..."

echo "Creating QucsStudio working directory..."

mkdir qucsstudio
cd QucsStudio
cat >> qucsstudio.sh << 'END'
wine /edatools/opentools/QucsStudio/bin/qucs.exe
END

chmod 777 qucsstudio.sh
cd ..

echo "Creating Qucs-S working directory..."

mkdir qucs-s
cd qucs-s
cat >> .spiceinit << 'END'
set ngbehavior=hs
END

#echo "Cloning ASITIC docker and setting up Inductor-generator working dir..."
 
echo "User script for RF workarea setup done!"
