echo "Setting up minimal sky130 PDK workarea"
mkdir sky130_skel
mkdir temp
cd temp
git clone https://www.github.com/britovski/sky130_skel
cp sky130_skel/minimal_libs.tgz ../sky130_skel
cd ../sky130_skel
tar zxvpf minimal_libs.tgz
rm minimal_libs.tgz
rm -rf ../temp

echo "Minimal sky130 PDK workarea done!"
