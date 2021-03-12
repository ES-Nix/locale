

# Nix + flakes + Podman

In this case you don't need to git clone, just have nix + flakes + podman:

```
nix build github:ES-Nix/locale/cca8762305629192c00cf5794a3fe4243b68bb11#locale
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

echo 'Second build:'
echo

nix build github:ES-Nix/locale/a0021da8f34abe91a49971d2c046a650486f4364#locale
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

# Via git clone

In this case you need:
- git 
- nix + flakes
- podman

```
git clone https://github.com/ES-Nix/locale.git
cd locale
git checkout dev

git checkout cca8762305629192c00cf5794a3fe4243b68bb11
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

echo 'Second build:'
echo

git checkout a0021da8f34abe91a49971d2c046a650486f4364
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