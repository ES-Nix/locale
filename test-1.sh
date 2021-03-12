#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE='locale:0.0.1'


podman \
run \
--interactive=true \
--tty=false \
--user=0 \
--workdir /code \
--volume "$(pwd)":/code \
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
&& rm -r /var/lib/apt/lists/* \
&& locale-gen pt_BR.UTF-8 \
&& cp /lib/locale/locale-archive /code
COMMANDS



podman \
run \
--interactive=true \
--rm=true \
--tty=false \
--user=0 \
--workdir /code \
--volume "$(pwd)":/code \
"$IMAGE" << COMMANDS
cp /code/locale-archive /lib/locale/locale-archive \
&& python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
COMMANDS
