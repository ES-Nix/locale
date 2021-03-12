



```
nix build .#locale
podman load < result
podman \
run \
--interactive=true \
--rm=true \
--tty=false \
localhost/locale:0.0.1 \
<< COMMANDS
ls -al /nix/store/*-glibc-locales-2.32-37
ls -al /nix/store/*-glibc-locales-2.32-37/lib/locale/locale-archive
file /nix/store/*-glibc-locales-2.32-37/lib/locale/locale-archive
COMMANDS
```
