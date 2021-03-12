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
"$IMAGE_VERSION" << COMMANDS
cd /nix/store/*-glibc-2.32-37/share/i18n/charmaps/ \
&& gzip --decompress --keep UTF-8.gz \
&& /nix/store/*-glibc-2.32-37-bin/bin/localedef --charmap=UTF-8 --inputfile=fi_FI ./fi_FI.UTF-8 --verbose \
&& ls -al fi_FI.UTF-8
COMMANDS


podman \
run \
--interactive=true \
--rm=true \
--tty=false \
--user=0 \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE_VERSION" << COMMANDS
cd /nix/store/*-glibc-2.32-37/share/i18n/charmaps/ \
&& gzip --decompress --keep UTF-8.gz \
&& /nix/store/*-glibc-2.32-37-bin/bin/localedef --charmap=UTF-8 --inputfile=pt_BR ./pt_BR.UTF-8 --verbose \
&& stat pt_BR.UTF-8 \
&& /nix/store/*-glibc-2.32-37-bin/bin/localedef --list-archive pt_BR.UTF-8
COMMANDS


/nix/store/*-glibc-2.32-37-bin/bin/locale --all-locales

export PATH=/nix/store/cp1sa3xxvl71cypiinw2c62i5s33chlr-binutils-2.35.1/bin:$PATH
export PATH=/nix/store/mbxi7rhg9pj2mfnzr7dk9cd46xdhnrf9-glibc-2.32-37-bin/bin:$PATH

file /nix/store/*-glibc-2.32-37/lib/locale/locale-archive

strings /nix/store/*-glibc-2.32-37/lib/locale/locale-archive
