# Config Linux

Linux system configuration for development under **Ubuntu 20.04 LTS (Focal Fossa) desktop**, it works also for Ubuntu server and Ubuntu wsl. It can work for **another Linux distribution or operating system** by using configurations of cross-platform tools.   

Website : https://ubuntu.com  
Desktop : https://www.ubuntu.com/desktop  
Server  : https://www.ubuntu.com/server  
WSL     : https://www.ubuntu.com/wsl  
Wiki    : https://wiki.ubuntu.com/LTS  
Help    : https://help.ubuntu.com  

To configure and see the Ubuntu configurations, install these 3 settings managers:

~~~ bash
sudo apt-get install dconf-editor gconf-editor \
  compizconfig-settings-manager
~~~

Use also `gsettings` in a terminal.  

Run ` compizconfig-settings-manager` with the command `ccsm` .

Install and use `Gnome Tweaks`:

```
sudo apt install gnome-tweaks gnome-shell-extensions \
  gnome-shell-extension-dash-to-panel gnome-tweaks adwaita-icon-theme-full
```
