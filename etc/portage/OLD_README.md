<img src="./logo.png" width=200>

# Portage

(...)

### Full system upgrade

Contracted form:
```shell
sudo emerge -vauDU @world
```

Extended form:
```shell
sudo emerge --verbose --ask --upgrade --deep --changed-use @world
```

### Continue a build process

After cancelling a build process within emerge (e.g. chromium), it can be resumed if all temporary build files are preserved; this can be checked by doing:
```shell
sudo du -sh /var/tmp/portage/www-client/chromium-114.0.5735.198
```
The corresponding `.ebuild` can be queried by doing:
```shell
equery w chromium
```
Wrapping all up, the build process can be resumed by doing:
```shell
sudo ebuild $(equery w chromium) merge
```

### 'Multiple pkg instances within a single pkg slot' problem

```shell
qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^CAT/PN'
```
