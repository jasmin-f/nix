{
  description = "My first flake, webstorm for WE1
  nix develop .#webstorm";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      # allowed-unfree-packages = [
      #     "webstorm"
      # ];
      
      # https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit
      pkgs = import nixpkgs { 
        inherit system;
        config = {
          allowUnfree = true;  # for webstorm
        };
      };

      
    in
    {
      
      # syntax aus beginner workshop folien
      devShells.${system} = {
        # nodejs = pkgs.mkShell {
        #   packages = [ pkgs.nodejs ];
        # };
        webstorm = pkgs.mkShell {
          packages = [ pkgs.jetbrains.webstorm ];
        };
      };
    };
# Problem:
# error: flake 'git+file:///mnt/c/Users/jf/code/wsl/nix?dir=webstorms-flake' does not provide attribute 'packages.x86_64-linux.webstorm', 'legacyPackages.x86_64-linux.webstorm' or 'webstorm'
}