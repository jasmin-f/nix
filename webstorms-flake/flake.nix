{
  description = "My first flake, webstorms for WE1";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system; 
      config.allowUnfree = true;  # for webstorms
      # # https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
    };

    #   in rec {
    #       # pkgs.webstorm;
    #       pkgs.jetbrains.webstorm;
    # });

  in rec
  {
    
    # aus Vorlage
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    # packages.x86_64-linux.webstorm = nixpkgs.legacyPackages.x86_64-linux.jetbrains.webstorm;
    # pkgs.jetbrains.webstorm;


  };
}
