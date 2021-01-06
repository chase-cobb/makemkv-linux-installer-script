# makemkv-linux-installer-script
Simple script for installing MakeMKV on Ubuntu based systems.

To use this script, either get a release, clone the repository or download a zip version of the script.  
  
  
Open terminal and cd to the directory of the script and run the following command.  

```
sudo chmod +x makemkv_install.sh
```  
  
The script will automatically install the latest version of MakeMKV when run without any arguments.
```
sudo sh makemkv_install.sh
```  

OPTIONAL : If users would like to install an old version, they may provide it as an argument. For example, the command below will install version 1.15.2
```
sudo sh makemkv_install.sh 1.15.2
```  

When the installer stops for the end user license agreement:  
* Press enter to view the license agreement
* Press 'Q' to exit the license agreement
* Type 'yes' and press enter to accept the agreement  

Now wait a few minutes the source code to compile and be installed!
