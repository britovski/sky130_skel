echo "ASITIC installation setup will begin..."

if [[ $EUID -ne 1000 ]]; then
   echo "This script must be run as user (with superuser access)"
   exit 1
fi

cd ~/sky130_skel

echo "Solving dependencies..."
sudo yum install glibc.i686 libXext.i686 libgcc.i686 -y
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/compat-libf2c-34-3.4.6-32.el7.i686.rpm
sudo rpm -ivh compat-libf2c-34-3.4.6-32.el7.i686.rpm
rm compat-libf2c-34-3.4.6-32.el7.i686.rpm 

echo "Creating ASITIC working directory..."

mkdir asitic
cd asitic

echo "Downloading and installing ASITIC..."
wget http://rfic.eecs.berkeley.edu/~niknejad/Asitic/grackle/asitic_linux.gz
gunzip asitic_linux.gz
chmod 777 asitic_linux

echo "Downloading ASITIC .tek file from yrrapt@github repository..."
wget https://raw.githubusercontent.com/yrrapt/inductor-generator/main/asitic/sky130.tek
 
echo "User script for ASITIC workarea setup done!"
