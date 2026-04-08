{
  description = "Dev Environment für DSy";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system;
    };
  in
  {      
    devShells.${system} = rec {
      default = pkgs.mkShell {
        packages = with pkgs; 
        [ 
          # nodejs
          nodejs_20 # downgraded
          just
          kind
          kubectl
        ];
        shellHook = ''
          echo ""
          echo "npm version 20"
          echo "just, kind, kubectl"
          echo "podman has to be installed manually"
          echo ""
        '';
      };
    };
  };
}