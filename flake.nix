{
  description = "Devshell templates";
  # Credits : https://github.com/omega-800/devshell-templates/blob/main/flake.nix

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      fs = lib.fileset;
      files = builtins.readDir ./src;
      
      # system = "x86_64-linux";
      # pkgs = import nixpkgs { 
      #   inherit system;
      # };

    in
    {
      templates =
        (lib.mapAttrs (n: _: {
          path = "${fs.toSource {
            root = ./src/${n};
            fileset = fs.fileFilter (f: !(f.hasExt "lock")) ./src/${n};
          }}";
          description = "${n} development environment";
        }) files)
        // lib.mapAttrs' (
          n: _:
          lib.nameValuePair "${n}-lock" {
            path = ./src/${n};
            description = "${n} development environment with flake.lock";
          }
        ) files;
    };
}