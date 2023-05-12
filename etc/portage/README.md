# Portage

(...)

### Useful commands

1. Full system upgrade
2. 'Multiple pkg instances within a single pkg slot' problem


### Full system upgrade

Contracted form:
```shell
sudo emerge -vauDU @world
```

Extended form:
```shell
sudo emerge --verbose --ask --upgrade --deep --changed-use @world
```

(...)

### 'Multiple pkg instances within a single pkg slot' problem

```shell
qdepends -CQqqF '%{CAT}/%{PN}:%{SLOT}' '^CAT/PN'
```

