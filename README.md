# ibnr
A set of configurable and extensible shell scripts for Ubuntu to add software PPAs, install softwares, backup and/or restore their corresponding dotfiles.

## Purpose
  Whenever you freshly install Ubuntu, one of the most popular Linux distro either in a VM or on a physical machine, you often require your favourite software also be installed with their latest and greatest versions with those awesome features. However, Ubuntu only ships their installation images with a particular version of these softwares in their offical respository. You may get the latest version during updates after the installation. Also, depending on the version of the distro, the versions of the software shipped may change and may even become unavailable. Some softwares are not even available for installation right away even not being present in the offical repositories.

  Softwares, be it whether present in the official repositories or not, often are maintaned in their own PPAs with different channels like stable and testing to distribute them. These PPAs are how most softwares are distributed and how most users of Ubuntu are directed to when they need to install them. Sotware available over these PPAs while not having gone through the validation process for the main/official repository, form the primary source for the best version available besides the official channel. It is also the most convenient way of installing them and recieving updates.
  
  There are however, other teams that do not make their own PPAs available but require that you build the code yourself if you want to use their software. They either require that you checkout their code from their SCM repo or download a tarball and build and install.
  
  **ibnr** provides a convenient way for you to automate the processes described above to install and if required, also [configure](https://github.com/wrvenkat/bnr) the installed software.

## Getting Started
* ibnr is a combination of two main tools - the install tool and the [bnr](https://github.com/wrvenkat/bnr) tool.

* ibnr is customizable in that it reads the configuration details of what software to install from the ppa_list.conf file inside the [ibnr-conf](https://github.com/wrvenkat/ibnr-conf) directory which is maintained separately. The install tool handles "dependencies" to an extent. This file is configurable. Please see [ibnr-conf](https://github.com/wrvenkat/ibnr-conf) for more information.
  
* While ibnr provides support for adding and installing software from PPAs, it also supports installation by running individual build scripts. Please see [install_Scripts](https://github.com/wrvenkat/install_scripts) for more information on this.

* All successful entries that have been installed are logged in the successful_ppa_list.conf file.

* All unsuccessful entries are the ones where the PPA was failed to be added, the install script failed or the installation failed are logged into failed_ppa_list.conf.

* An error.log is created with output from all operations that failed.
  
## Usage
  
`This script installs most commonly required software on an Ubuntu system. The script installs softwares from PPA channels and also optionally runs additional scripts to install softwares that need to be compiled form source. The script parses a file with configuration information to do this.`  
`Output includes an error.log file that logs errors and files, successful_ppa_list.conf and failed_ppa_list.conf similar to the config file for successful and failed entries respectfully. These can be used in further processing like trying to re-install failed installations and/or used as secondary config file in restoring configuration by the bnr script.`

`Running`  
`./install <arguments>`

`Arguments`  
`-h | --help`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- display this message and quit.`  
`--file=ppa-list-file-path`&nbsp;`- the config file to be used instead of the default one.`  
`--list`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- display the parsed contents of the config file.`  
`--add`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- add the PPA for the softwares.`  
`--install`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- install the software present in the config file.`  
`--type=[b,d,d1,d2...]`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`- used in conjuction with --list and --install options, a value to this option indicates the type of software to be displayed or installed. Values can be comma separated. The default value is b for the base level. (b - basic/core requirements). Other examples would be, d - desktop, dev - development, etc.`

#### Example
  
  1. Get a stable copy of the project:  
  `git clone --recursive https://github.com/wrvenkat/ibnr.git && git checkout stable`
  2. Navigate to ibnr-conf directory and get the config file for your Ubuntu version:  
  `cd ibnr-conf; git checkout <your_ubuntu_version>`  
  Example: `cd ibnr-conf; git checkout 16.04`
  3. Navigate back to the project dir and run the tool to list the config file, add the PPAs and install the software:  
  `cd ..; ./install --list --add --install`
  4. Optionally, run the tool again with one of the output file to attempt to install failed ones:  
  `./install --list --install --file=failed_ppa_list.conf`

## Contributing

Contributions are welcome. Please see CONTRIBUTE.md.

## LICENSE

[GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)
