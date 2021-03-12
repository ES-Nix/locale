{ pkgs ? import <nixpkgs> {} }:
pkgs.dockerTools.buildImage {
    name = "locale";
    tag = "0.0.1";

    contents = with pkgs; [
        coreutils
        file
        glibc
        glibcLocales

        # All python variants makes glibcLocales paths disappear
        #python3
        #python38Full
        #python
        #python3Minimal
    ];

    config.Entrypoint = [ "${pkgs.bashInteractive}/bin/bash" ];
}