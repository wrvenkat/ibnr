# ibnr
A set of configurable and extensible shell scripts for Ubuntu to batch add software PPAs, install softwares and backup/restore their corresponding dotfiles.

## Purpose
  Whenever you freshly install Ubuntu, in either a VM or on a physical machine, you often require the latest versions of your favourite softwares also be installed so that you can just start using it conveniently. However, Ubuntu only ships their installation images with a particular version of these softwares in their offical respository. You may get the latest version during updates after the installation.

  PPAs are how most softwares are distributed and how most users of Ubuntu install them. Sotware versions available over these PPAs may or may not be stable not having gone through the validation process for the main/official repository, form the primary source for the best version available besides the official channel. It is also the but it the most convenient way of installing them and recieving updates.
  
  There are however, other teams that do not make their softwares available through PPA but require that you build and install them from source.
  
  You may also seek a setup of the new installation that just works with the same tweaks and customizations that you made earlier. This means, restoring any configuration files or dotfiles for the softwares just installed. You would also like to backup these dotfiles from a previous or current installation to restore later.
  
  **ibnr** provides a convenient way for you to automate the processes described above to install and if required, also [configure](https://github.com/wrvenkat/bnr) the installed software.

## Getting Started
* ibnr is a combination of two main tools - the install tool and the [bnr](https://github.com/wrvenkat/bnr) tool.

* ibnr is customizable in that it reads the configuration details of what software to install from the ppa_list.conf file inside the [ibnr-conf](https://github.com/wrvenkat/ibnr-conf) directory. The install tool handles "dependencies" to an extent. Please see [ibnr-conf](https://github.com/wrvenkat/ibnr-conf) for more information.
  
* While ibnr provides support for adding and installing software from PPAs, it also supports installation by running individual build scripts. Please see [install_scripts](https://github.com/wrvenkat/install_scripts) for more information on this.

* All successful entries that have been installed are logged in the successful_ppa_list.conf file. All unsuccessful entries are the ones where either the PPA was not added, install script failed or the installation failed. These entries are logged into failed_ppa_list.conf. Both these entries have the same format as [ibnr-conf](https://github.com/wrvenkat/ibnr-conf) and hence can be used further.

* An error.log is created with output from all operations.
  
## Usage

`usage: ./install <options>`

`Options`  
`-h | --help`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- display this message and quit.`  
`--file=ppa-list-file-path`&nbsp;`- the config file to be used instead of the default one.`  
`--list`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- display the parsed contents of the config file.`  
`--add`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- add the PPA for the softwares.`  
`--install`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- install the softwares present in the config file.`  
`--type=[b,d,d1,d2...]`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- used in conjuction with --list and --install options, a value to this option indicates the type of software to be displayed or installed. Values are comma separated. The default value is b for the base level. (b - basic/core requirements). Other examples would be, d - desktop, dev - development, g- games etc.`

#### Example
  
  1. Get a stable copy of the project:  
  `git clone https://github.com/wrvenkat/ibnr.git`
  2. Get a copy of the config file for your Ubuntu version or you can use your own version:  
  `git clone https://github.com/wrvenkat/ibnr-conf.git && checkout <your_ubuntu_version>`  
   Example: `git clone https://github.com/wrvenkat/ibnr-conf.git && checkout 16.04`  
  3. Get a copy of the install scripts for your Ubunut version:  
  `git clone https://github.com/wrvenkat/install_scripts.git && git checkout <your_ubuntu_version>`  
   Example: `git clone https://github.com/wrvenkat/install_scripts.git && git checkout 16.04`  
  4. Run the tool to list the config file, add the PPAs and install the software:  
  `./install --list --add --install`  
  5. Optionally, run the tool again with one of the output file to attempt to install failed ones:  
  `./install --list --install --file=failed_ppa_list.conf`

## Contributing

Any type of contribution is welcome! :) The dev branch holds the unstable under development code. The master branch holds the latest stable.

## LICENSE

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
