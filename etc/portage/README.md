# Portage

(...)

## Useful commands

1. Full system upgrade
2. Continue a build process
3. 'Multiple pkg instances within a single pkg slot' problem

### 1. Full system upgrade

Contracted form:
```shell
sudo emerge -vauDU @world
```

Extended form:
```shell
sudo emerge --verbose --ask --upgrade --deep --changed-use @world
```

### 2. Continue a build process

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

### 3. 'Multiple pkg instances within a single pkg slot' problem

```shell
qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^CAT/PN'
```

