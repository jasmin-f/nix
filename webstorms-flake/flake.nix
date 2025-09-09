{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  
  
  {

    # # https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
    # flake-utils.lib.eachDefaultSystem (system:
    #   let
    #     pkgs = import nixpkgs { 
    #       inherit system;
    #       config.allowUnfree = true;  # like this
    #     };
    #   in rec {
    #       # pkgs.someUnfreeThing is referenced somewhere in here
    #       # pkgs.webstorm;
    #       pkgs.jetbrains.webstorm;
    # });

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}
