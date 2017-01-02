# ibnr
A set of highly configurable and extensible shell scripts for Ubuntu to add software PPAs, install software, backup and/or restore their corresponding dotfiles.

## Description
ibnr is a tool or a set of tools that lets you install and configure some of the popular software tools on an Ubuntu installation.

## Purpose
  Whenever you freshly install Ubuntu, one of the most popular Linux distro either in a VM or on a physical machine, you often require your favourite software also be installed with their latest and greatest versions with those awesome features. However, Ubuntu only ships their installation images with a particular version of these softwares in their offical respository. You may get the latest version during updates after the installation. Also, depending on the version of the distro, the versions of the software shipped may change and may even become unavailable. Some softwares are not even available for installation right away even not being present in the offical repositories.

  Softwares, be it whether present in the official repositories or not often are maintaned in their own PPAs with different ones for different channels like stable and testing to distribute them. These PPAs are how most softwares are distributed and how most users of Ubuntu are directed towards to install them. Sotware available over these PPA while not having gone through the validation process for the main/official repository, form the primary source for best version available besides the official channel. It is also the most convenient way of installing and recieving updates.
  
  There are however, other teams that do not make their own PPAs available but require that you build the code yourself if you want to use their software. They either require that you checkout their code from their SCM repo or download a tarball and then use their build system to buid and install.
  
  **ibnr** provides a convenient way for you to automate the install and if required, also the [configuration](https://github.com/wrvenkat/bnr) of your software.

## Getting Started
  ibnr is a combination of two main tools - the install tool and the [bnr](https://github.com/wrvenkat/bnr) tool.
  
  ibnr is customizable in that it reads the configuration details of what software to install from the ppa_list.conf file inside the [ibnr-conf](https://github.com/wrvenkat/ibnr-conf) directory which is maintained separately. The install tool handles "dependencies" to an extent. This file is configurable. Please see [ibnr-conf](https://github.com/wrvenkat/ibnr-conf) for more information.
  
  While ibnr provides support for adding and installing software from PPAs, it also supports installation by running individual build scripts.
  
  These instructions will get you a copy of the project geared towards using the tool.
  
  1. Get a copy of the project run:
  `git clone --recursive https://github.com/wrvenkat/ibnr.git`
  2. Navigate to ibnr-conf directory and run:
  `cd ibnr-conf; git checkout <your_ubuntu_version>`
  Example:
  `cd ibnr-conf; git checkout 16.04`
  3. Navigate back to the project dir and run the tool:
  `cd ..; ./bnr --list --add --install`
  
  
## Usage
  
