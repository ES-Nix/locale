#!/usr/bin/env bash


# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euxo pipefail


IMAGE='locale:0.0.1'


echo 'Testing if bash works.'
podman \
run \
--interactive=true \
--rm=true \
--tty=true \
--user=ada \
"$IMAGE" -c 'ls -la'

podman \
run \
--interactive=true \
--rm=true \
--tty=true \
--user=ada \
"$IMAGE" -c 'id'

podman \
run \
--interactive=true \
--rm=true \
--tty=true \
--user=ada \
"$IMAGE" -c 'file test/locale/locale-archive'

podman \
run \
--interactive=true \
--rm=true \
--tty=true \
--user=ada \
"$IMAGE" -c 'find /bin -exec file {} \;'


#podman \
#run \
#--interactive=true \
#--tty=true \
#--user=0 \
#--workdir /code \
#--volume "$(pwd)":/code \
#"$IMAGE" -c 'cp /nix/store/*-glibc-2.32-37/lib/locale/locale-archive /code'

#podman \
#run \
#--interactive=true \
#--name=ubuntu-locale \
#--tty=true \
#ubuntu:20.04 bash -c 'apt-get update && apt-get install -y --no-install-recommends python3 locales && find /usr/share/locale/* ! -name 'pt_BR' -type d -exec rm --force --recursive {} + && apt-get -y autoremove && apt-get -y clean && rm -r /var/lib/apt/lists/*'
#


#podman \
#run \
#--interactive=true \
#--name=ubuntu-locale \
#--tty=true \
#--user=0 \
#--workdir /code \
#--volume "$(pwd)":/code \
#ubuntu:20.04 bash
#
#apt-get update && apt-get install -y --no-install-recommends python3 locales file
#
#python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
#file /lib/locale/locale-archive
#
#locale-gen pt_BR.UTF-8
#
#file /lib/locale/locale-archive
#python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
#
#rm /lib/locale/locale-archive
#
#cp /code/locale-archive /lib/locale/locale-archive
#
#
#file /lib/locale/locale-archive
#python3 -c 'import locale; locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")'
#


#echo 'Testing if bash works:'
#podman \
#run \
#--interactive \
#--tty \
#bash-layered-with-user \
#bash -c 'ls -la'
#
#
#echo 'Test if the user is the root one, passing explicitly with the flag --user'
#podman \
#run \
#--interactive \
#--tty \
#--user=root \
#bash-layered-with-user \
#bash -c 'id'
#
#echo 'Test if the user is the root one'
#podman \
#run \
#--interactive \
#--tty \
#bash-layered-with-user \
#bash -c 'id'
#
#echo 'Test if the user is the somebody one'
#podman \
#run \
#--interactive \
#--tty \
#--user=somebody \
#bash-layered-with-user \
#bash -c 'id'
