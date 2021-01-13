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

Just download the minimal_installation.sh script and run it.

### It continues...

