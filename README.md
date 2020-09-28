# Config Linux

Linux configuration system for development under **Ubuntu 20.04 LTS (Focal Fossa) desktop**.  

Website : http://www.ubuntu.com/desktop   
Wiki : https://wiki.ubuntu.com/LTS  
Help : https://help.ubuntu.com  

To see file configuration for each technology, install these three GUI settings managers:

~~~ bash
sudo apt-get install dconf-editor gconf-editor \
  compizconfig-settings-manager
~~~

Use also `gsettings` in the terminal shell.  

Run ` compizconfig-settings-manager` with the command `ccsm` .

Install and use `Gnome Tweaks`:

```
sudo apt install gnome-tweaks gnome-shell-extensions \
  gnome-shell-extension-dash-to-panel gnome-tweaks adwaita-icon-theme-full
```

## configuration

Enable minimise a windows when clik related windows icon on the Ubuntu Dock:

~~~
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
~~~
