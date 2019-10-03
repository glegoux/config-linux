# Git

Website https://git-scm.com/ .

## Git Repo

Git source code used Git itself for versioning.

* HTML : https://git.kernel.org/cgit/git/git-htmldocs.git/
* Man Pages : https://git.kernel.org/cgit/git/git-manpages.git/
* Source code : https://git.kernel.org/cgit/git/git.git/

## Version

See your version with:

```
git --version
```

Check release note:

```
curl https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/RelNotes/$(git --version | cut -f3 -d' ').txt
```

## PPA

The Ubuntu git maintainers team has a PPA, ppa:git-core/ppa.  
See https://launchpad.net/~git-core/+archive/ubuntu/ppa .

~~~ bash
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git
~~~

## Auto-completion and prompt

~~~
curl -o ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
~~~

Then load these files in `.bashrc`.

## GUI

Install these GUI clients to view git repositories :

~~~ bash
sudo apt-get install gitg
~~~

see https://wiki.gnome.org/action/show/Apps/Gitg .

~~~ bash
sudo apt-get install git-gui gitk
~~~

see `man gitk`.

~~~ bash
sudo apt-get install tig
~~~

see https://github.com/jonas/tig .
