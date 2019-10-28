# Brightness

Command-LIne:

~~~
$ xrandr | grep " connected" | cut -f1 -d " "
~~~

Then:

~~~
$ xrandr --output DP-1 --brightness 0.75
~~~

if dual screen:

~~~
$ xrandr --output DP-2 --brightness 0.75
~~~
