# Gedit - GNOME Text Editor.

See official website, https://wiki.gnome.org/Apps/Gedit .

Install extension plugins :

~~~bash
sudo apt-get install gedit-plugins
~~~

Import configuration :

~~~bash
dconf load /org/gnome/gedit/ < org.gnome.gedit
~~~

Export configuration :

~~~bash
dconf dump /org/gnome/gedit/ > org.gnome.gedit
~~~

See configuration :

~~~bash
gsettings list-recursively | grep ^org.gnome.gedit 
~~~
