#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


podman \
run \
--interactive=true \
--rm=true \
--tty=false \
--user=0 \
ubuntu:20.04 \
bash << COMMANDS
apt-get update \
&& apt-get install -y --no-install-recommends \
   file \
   locales \
   python3 \
&& find /usr/share/locale/* ! -name 'pt_BR' -type d -exec rm --force --recursive {} + \
&& apt-get -y autoremove \
&& apt-get -y clean \
&& rm -r /var/lib/apt/lists/*

locale-gen pt_BR.UTF-8
python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'

echo '-----------------'

rm /lib/locale/locale-archive
python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
COMMANDS
