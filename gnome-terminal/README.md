# GNOME Terminal  

version 3.6.2 (see in the menu `Help > About` ).  

See official website, https://help.gnome.org/users/gnome-terminal/stable/ .

Import this configuration to Gnome terminal with :  

~~~ bash
gconftool-2 --load profile.xml
~~~

You can delete `profile.xml` after importing.

Open a new Terminal, or switch to the new profile in the menu `Terminal > Change Profile`.

Export your current configuration :

~~~ bash
gconftool-2 --dump '/apps/gnome-terminal' > profile.xml
~~~

You can install the extensions with :

~~~ bash
sudo apt install gnome-shell-extensions
~~~
