{
  description = "Dev Environment für .NET (nicht in Verwendung)";

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
          packages = with pkgs; [ 
            jetbrains.rider 
            dotnetCorePackages.sdk_8_0_3xx-bin
          ];

          shellHook = ''
            echo ""
            echo ".NET für kleine Projekte"
            echo ""
          '';
        };
    };
  };
}