{
  description = "Dev Environment für .NET (nicht in Verwendung)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: 
  supportedSystems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
  forEachSupportedSystem =
    f:
    inputs.nixpkgs.lib.genAttrs supportedSystems (
      system:
      f {
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.self.overlays.default ];
        };
      }
    );
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