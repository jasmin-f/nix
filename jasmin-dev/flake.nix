{
  description = "My first flake
  developer environments 2025";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;  # for webstorm license
      };

    in
    {      
      
      devShells.${system} = rec {
        # nix develop
        default = pkgs.mkShell {
          packages = [  ];
        };

        # nix develop .uml
        web = pkgs.mkShell with pkgs {
          packages = [ umlet plantuml ];
        };


      };

    };
}