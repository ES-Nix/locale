#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE='locale:0.0.1'

podman \
run \
--interactive=true \
--rm=true \
--tty=false \
--user=0 \
--workdir /code \
--volume "$(pwd)":/code \
docker.io/lnl7/nix:2020-09-11 << COMMANDS
mkdir --parent ~/.config/nix/nix \
 && echo 'experimental-features = nix-command flakes ca-references' >> ~/.config/nix/nix.conf

 nix-env --install --attr nixpkgs.commonsCompress nixpkgs.gnutar nixpkgs.lzma.bin nixpkgs.git

 nix-shell -I nixpkgs=channel:nixos-20.09 --packages nixFlakes

nix shell --ignore-environment nixpkgs#{python3,which,readlink}
which python
python --version
python -c 'print("Hello!")'
python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "C.UTF-8")'
COMMANDS
