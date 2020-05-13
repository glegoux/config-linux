# Python

/!\ Sunset for python2: https://www.python.org/doc/sunset-python-2/ since January 1, 2020

Use python3+ with [pyenv-installer](https://github.com/pyenv/pyenv-installer) and [virtualenv](https://github.com/pypa/virtualenv)

Configure python and pip to version 3 per default:

```
sudo ln -sf /usr/bin/python3 /usr/bin/python
sudo ln -sf /usr/bin/pip3 /usr/bin/pip
```

Install virtualenv (even if pyenv virtualenv is available):

```
sudo apt install virtualenv
```

Install pyenv, then specific python version and use that globally (or locally):

```
curl https://pyenv.run | bash
pyenv install 3.6.7
pyenv [global|local] 3.6.7
pyenv which python
```

Check `~/.pyenv`, you can update your PATH to use `pyenv` command.

