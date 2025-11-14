Breakdown:

`VBLV=$(wget -qO- https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT)`

The content of the file `LATEST-STABLE.TXT` gives us gives us the version (and with it the folder name) we need. We save this in the variable `VBLV` which we can use in the next commands:

```
VBGI=$(wget -qO- https://download.virtualbox.org/virtualbox/${VBLV}/SHA256SUMS | grep ".run" -m1 | awk '{print $2}' | sed 's/*//g')
VBEP=$(wget -qO- https://download.virtualbox.org/virtualbox/${VBLV}/SHA256SUMS | grep ".extpack" -m1 | awk '{print $2}' | sed 's/*//g')
```

The `SHA256SUMS` file contains a list of file names with the respective hash. Here is an example:
```
[...]
ace74a8a7997b514b7c69a042edfe138d45fa1851435a94ae66a0f1c6db1962f *VirtualBox-7.0-7.0.20_163906_openSUSE153-1.x86_64.rpm
2b4c3522987cd7c97f54757de1e1afa106b725f99080d0c38ddf0448941ebf6b *VirtualBox-7.0.20-163906-Linux_amd64.run
3d7b8833780cb274419a6209995f45889e96ad68fddb993fbeea0ad69722a821 *VirtualBox-7.0.20-163906-OSX.dmg
42c6e1357c4bcaa46d74e8ec56ec45a62948052361eed0d9a01c8275f8fec0d7 *VirtualBox-7.0.20-163906-Solaris.p5p
[...]
```
With `grep` we get the lines with the generic installer and the extension pack. Then we use `awk` to get the second column and `sed` takes care of the asterisk, which we don't need. We save the results in the variables `VBGI` and `VBEP` respectively.

`wget -qO-` is the short version of `wget -q -O -` and means quiet (-q) output to standard output (-O -)

Now we can download the generic installer and the extension pack:

```
wget "https://download.virtualbox.org/virtualbox/${VBLV}/${VBGI}"
wget "https://download.virtualbox.org/virtualbox/${VBLV}/${VBEP}"
```

Then we have to make the installer executable and can run it afterwards:

```
chmod +x ${VBGI}
sudo ./${VBGI} install
```

The first of the next commands is not actually necessary and is only included for safety reasons. It ensures that the necessary kernel modules are built. The second command ensures that our currently logged-in user (logname) is assigned to the correct user group (this is necessary for accessing USB):

```
sudo rcvboxdrv setup
sudo usermod -a -G vboxusers $(logname)
```

And in the last step, we install the current extension pack:

`sudo VBoxManage extpack install --replace ${VBEP}`

Sources that I used:

* https://bbs.archlinux.org/viewtopic.php?pid=2052713#p2052713
* https://unix.stackexchange.com/a/290462
* https://unix.stackexchange.com/a/414657
* https://unix.stackexchange.com/a/294493
* https://stackoverflow.com/a/43763737
* https://stackoverflow.com/a/42258826
* https://www.virtualbox.org/manual/ch02.html#install-linux-host
* https://cheat.sh/
