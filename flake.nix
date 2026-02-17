{
  description = "Devshell templates";
  # Credits : https://github.com/omega-800/devshell-templates/blob/main/flake.nix

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      fs = lib.fileset;
      files = builtins.readDir ./nix-flakes;
    in
    {
      templates =
        (lib.mapAttrs (n: _: {
          path = "${fs.toSource {
            root = ./nix-flakes/${n};
            fileset = fs.fileFilter (f: !(f.hasExt "lock")) ./nix-flakes/${n};
          }}";
          description = "${n} development environment";
        }) files)
        // lib.mapAttrs' (
          n: _:
          lib.nameValuePair "${n}-lock" {
            path = ./nix-flakes/${n};
            description = "${n} development environment with flake.lock";
          }
        ) files;
    };
}