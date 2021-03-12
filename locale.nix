{ pkgs ? import <nixpkgs> {} }:
let
    nonRootShadowSetup = { user, uid, gid ? uid }: with pkgs; [
      (
      writeTextDir "etc/shadow" ''
        ${user}:!:::::::
      ''
      )
      (
      writeTextDir "etc/passwd" ''
        ${user}:x:${toString uid}:${toString gid}::/home/${user}:${runtimeShell}
      ''
      )
      (
      writeTextDir "etc/group" ''
        ${user}:x:${toString gid}:
      ''
      )
    ];
in
pkgs.dockerTools.buildImage {

    name = "locale";
    tag = "0.0.1";

    contents = with pkgs; [
        #bashInteractive
        #binutils
        coreutils
        #debianutils
        file
        #findutils
        glibc
        glibcLocales
        #gzip

        python3
        #python38Full
        #python
        #python3Minimal

        #which
    ] ++ nonRootShadowSetup { uid = 999; gid = 888; user = "ada"; };

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];

    # It gives me a  Permission denied error
    #runAsRoot = ''
    #  #!${pkgs.stdenv.shell}
    #  mkdir --parent /lib/locale/
    #  ${pkgs.glibcLocales}/lib/locale/locale-archive pt_BR.UTF-8
    #'';
}