{
  description = "A usefull description";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
        pkgsAllowUnfree = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };
    in
    {

      packages.locale = import ./locale.nix {
        pkgs = nixpkgs.legacyPackages.${system};
      };

      #devShell = pkgsAllowUnfree.mkShell {
      #  buildInputs = with pkgsAllowUnfree; [
      #                neovim
      #               ];
      #    shellHook = ''
      #      unset SOURCE_DATE_EPOCH
      #      echo 'Working!'
      #    '';
      #};
  });
}
