

# Nix + flakes + Podman

In this case you don't need to git clone, just have nix + flakes + podman:

```
nix build github:ES-Nix/locale/d7f4070119227a440646f254b0c05ed6d108b57a#locale
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

nix build github:ES-Nix/locale/28bce929a7a0fe7e08f119af25d4b53acbce0ee3#locale
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

git checkout d7f4070119227a440646f254b0c05ed6d108b57a
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

git checkout 28bce929a7a0fe7e08f119af25d4b53acbce0ee3
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