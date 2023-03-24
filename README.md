# sky130_skel

This repository contains scripts and some libraries for setting up EDA open source tools and the open source skywater 130 nm PDK with different design flows.

## Guiding instructions

### Pre-requisites
First of all you need to have linux! The scripts were implemented and tested for CentOS 7 distribution (7.9) since is the most commonly used due to support for EDA (commercial) tools, but Ubuntu is also much used from open source community and the scripts can be adapted to use with it.

So you need to have an installation of CentOS 7 on your computer. If you don´t have yet, you need to choose between 3 options:
- single linux installation;
- dual-boot installation (if you really want to maintain windowns, or maybe macOSX);
- linux on a virtual machine (VM) running on windows.

Of course, the worst option is to run on a virtual machine because virtualization can slower the processing, but works, and I tested the scripts in both "dedicated" linux and also using Oracle VirtualBox VM's.

If you want to know how to install CentOS 7 see the following instuctions: https://linoxide.com/how-tos/centos-7-step-by-step-screenshots/

At least 20 Gb space is required for minimal or recommended installation. At least 40 Gb space for basic standard cells PDK installation with openlane or qflow base flows; and at least 60 Gb if you want all PDK standard cells installed for digital flow.

### Minimal Skel
Once you have a fresh CentOS 7 Linux installed, you can setup an skel to use sky130 open PDK, following below steps:

Step 1. Download (or clone the repository) and change scripts file permissions.
        
        chmod 777 *.sh

Step 2. Run the 'minimal_opentools.sh' as root and them download and run the 'minimal_sky130_skel.sh' script as user.

        su
        ./minimal_opentools.sh
        exit
        ./minimal_sky130_skel.sh

I call this first option as minimal since it support basic design flow with following open source EDA tools:
- ngspice (version 33) with ADMS support;
- magic (version 8.3);
- netgen (version 1.5).
    
and also, minimal sky130 models for circuit simulation and a `.tech` file.

The directory structure is organized as follow:
```bash 
/edatools/
  └── opentools
  └── pdks
```

and

```bash 
~/sky130_skel/
    └── minimal_libs
```

where `opentools` has the EDA tools and `pdks`the PDK libraries and utilities (`pdks` is not created for **minimal** setup).

and `sky130_skel` is the user working directory.

Of course, you can customize the scripts to do in a different way.

This minimal setup will provide you to simulate netlists using an **SPICE deck** using sky130 simples `.lib` files as well as to create layouts and perform DRC and LVS checks. If you want to use an schemactic capture support and more PDK models, go to the **Custom AMS (Recommended)** installation flow.

### Custom AMS (Recommended)
For this setup you need Minimal skel done (**as performed in steps 1 and 2**), then go to steps below:

Step 3. Run the 'recommended_opentools_update.sh' as root and then run the 'recommended_AMS_sky130_pdk_install.sh' scripts as user (if you not yet change permissions, do Step 1 again before).

        su
        ./recommended_opentools_sky130_update.sh
        exit
        ./recommended_AMS_user_update.sh

Note that to finish the setup you will need to do the following:

    echo "#####################################################################################################################"
    echo "To complete the workarea setup you need to update the last two lines of the file 'xschemrc' with the following paths:"
    echo "set SKYWATER_MODELS $TOOLS_DIR/pdks/skywater-pdk/libraries/sky130_fd_pr_ngspice/latest"
    echo "set SKYWATER_STDCELLS $TOOLS_DIR/pdks/skywater-pdk/libraries/sky130_fd_sc_hd/latest"
    echo "#####################################################################################################################"

This scripts solve some additional dependencies and install two new tools:
- xschem (version XX); and
- klayout (version XX).

also, they install all `skywater-pdk` libraries in `pdks` directory, as well as `xschem_sky130` directory inside `sky130_skel` to support configured xschem+sky130 workflow.

The directory structure is like below:
```bash 
/edatools/
  └── opentools
        └── adms
        └── ngspice
        └── magic
        └── netgen
        └── xschem
        └── klayout
  └── pdks
        └── skywater-pdk
```

and

```bash 
~/sky130_skel/
    └── minimal_libs
    └── xschem_sky130
  
```

Run xschem from `xschem_sky130` directory and explore the examples.

### AMS/Digital Flow
For this setup you need Minimal skel done (or recommended).

Then download, change permissions, and run the scripts 'digital_install.sh' as root and 'digital_user_install.sh' as user, as follows:

        su
        ./digital_install.sh
        exit
        ./digital_user_install.sh

Follow the final script instructions in order to test if installation was ok.

This scripts solve some additional dependencies and install following new tools:
- ghdl (version XX);
- iverilog (version XX);
- GTKWave viewer;
- Yosys;
- Graywolf;
- Qrouter;
- Qflow;
- OpenSTA.

### Advanced Digital Flow
For this setup you need Minimal skel done (or recommended).

Then download, change permissions, and and run the scripts 'openlane_sky130_install.sh' as root and 'openlane_user_install.sh' as user, as follows:

        su
        ./openlane_sky130_install.sh
        exit
        ./openlane_user_install.sh

To run openlane with the locally built docker image, run the following steps:

        cd ~/sky130_skel/openlane
        export PDK_ROOT=/edatools/pdks
        docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) openlane:rc6
        ./flow.tcl -design 'design_name'
 
See https://github.com/efabless/openlane for more informations on how to use openlane. 

### RF Flow

For this setup you need Minimal skel done (or recommended).

Then download, change permissions, and and run the scripts 'rfopentools_install.sh' as root and 'rf_user_install.sh' as user, as follows:

        su
        ./rfopentools_install.sh
        exit
        ./rf_user_install.sh

This scripts solve some additional dependencies and install two new tools:
- Qucs-S with Xyce and qucs/qucsator (version XX); and
- QucsStudio (version XX);

In order to use QucsStudio, enter the directory `~/sky130_skel/qucsstudio` and type `./qucsstudio &`. First time you use, a graphical user interface ask you to install some wine complementary libs. Just click `install` and wait to QucsStudio open.

### Inductor synthesis and EM sims Flow

Work in progress. (ASITIC and OpenEMS)

### Extras

#### CentOS Post-installation guide (in portuguese)
https://www.vivaolinux.com.br/artigo/CentOS-7-Guia-pratico-pos-instalacao

#### Other (not covered here) open source tools:
##### From http://opencircuitdesign.com/
- IRSIM – switch-level simulator
- XCircuit – just to draw high-quality schematics.

##### Wcalc

##### Nghdl – ghdl/ngspice interface

##### Verilator

##### Other needed:
- PCB (Kicad)
- BOM Generator

##### Suites:
- eSim
- gEDA
- Electric

##### Viewers
- Gaw (originally from gEDA/gwave)

##### Web-based
- Falstad
- EasyEDA
- EDAplayground

Work in progress...

https://semiwiki.com/wikis/industry-wikis/eda-open-source-tools-wiki/
