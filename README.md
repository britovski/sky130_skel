# sky130_skel

This repository contains scripts and some libraries for setting up EDA open source tools and the open source skywater 130 nm PDK with different design flows.

## Guiding instructions

### Pre-requisites
First of all you need to have linux! The scripts were implemented and tested for CentOS 7 distribution since is the most commonly used due to support for EDA (commercial) tools, but Ubuntu is also much used from open source community and the scripts can be adapted to use with it.

So you need to have an installation of CentOS 7 on your computer. If you don´t have yet, you need to choose between 3 options:
- single linux installation;
- dual-boot installation (if you really want to maintain windowns or maybe mac OSs);
- linux on a virtual machine (VM) running on windows.

Of course, the worst option is to run on a virtual machine because virtualization will imply to a slower processing, but works, and I tested all in both dedicated linux and also using Oracle VirtualBox VM's.

If you wan´t to know how to install CentOS 7, see the following instuctions: LINK

Here are also a brief guide to install it on a VM: LINK

### Minimal skel
Onde you have fresh CentOS 7 Linux installed, you can setup an skel to use sky130 open PDK. I call this first option as minimal since it support basic design flow with ngspice (with ADMS support), magic and netgen; with minimal models for sky130 primitives and tech file.

Just download and run the 'minimal_opentools.sh' as root and them download and run the 'minimal_sky130_skel.sh' script as user. 

### Custom AMS (Recommended)
For this setup you need Minimal skel done.

Then download and run the 'recommended_opentools_update.sh' as root and them download and run the 'recommended_AMS_sky130_pdk_install.sh' scripts as user.

Note that to finish the setup you will need to do the following:

    echo "#####################################################################################################################"
    echo "To complete the workarea setup you need to update the last two lines of the file 'xschemrc' with the following paths:"
    echo "set SKYWATER_MODELS $TOOLS_DIR/pdks/skywater-pdk/libraries/sky130_fd_pr_ngspice/latest"
    echo "set SKYWATER_STDCELLS $TOOLS_DIR/pdks/skywater-pdk/libraries/sky130_fd_sc_hd/latest"
    echo "#####################################################################################################################"

### AMS/Digital

Work in progress. (Qflow based)

### Advanced Digital
For this setup you need Minimal skel done (or recommended).

Then download and run the 'openlane_sky130_install.sh' as root and them download and run the 'openlane_user_install.sh' scripts as user.

### RF

Work in progress. (Qucsstudio, qucs-s, xyce or post-processing based)

### Inductor synthesis and EM sims Flow

Work in progress. (ASITIC and OpenEMS)

### Extras

Guia Pós-Instalação CentOS
https://www.vivaolinux.com.br/artigo/CentOS-7-Guia-pratico-pos-instalacao

Other open source tools:
http://opencircuitdesign.com/
-	IRSIM – switch-level simulator
-	XCircuit – just to draw high-quality schematics.

-	Wcalc

-	Nghdl – ghdl/ngspice interface

Digital:
-	Ghdl
-	Icarus Verilog
-	verilator

Other needed:
-	PCB (Kicad)
-	BOM Generator

Suites:
-	eSim
-	gEDA
-	Electric

Viewers:
-	GTKWave
-	Gaw (originally from gEDA/gwave)

Web-based
-	Falstad
-	EasyEDA
