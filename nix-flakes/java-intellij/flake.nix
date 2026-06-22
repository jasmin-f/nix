{
  description = "Dev Environment für Java mit Intellij";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system;
      config.allowUnfree = true;
    };
  in
  {      
    devShells.${system} = rec {
      default = pkgs.mkShell {
          packages = with pkgs; [ 
            # jetbrains.intellij 
            jetbrains.idea
          ];

          shellHook = ''
            echo ""
            echo "Intellij"
            echo ""
          '';
        };
    };
  };
}