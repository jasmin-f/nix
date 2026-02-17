{
  description = "C++ Dev Environment";

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
            (openssl.override { static = true; })
            # C++ Compiler is already part of stdenv
            #boost 
            #catch2 # in cmakelist schon intergriert
            cmake #build generator
            ninja # build tool (ninja oder make nötig)
            rocmPackages.clang
          ];
            
          # vs code extensions (.vscode/extensions.json)
            # - C/C++ (intellisense und mehr)
            # - CMake Tools
            # kein clangd!
            
          # Einstellungen in .vscode/settings.json

          # bei build mit "play button" auswählen wo ich arbeite.
          # ctrl+shift+f5 um das ausgewählte target laufen zu lassen (wie mit dem play button) 
          # Status Bar unten enthält viele Optionen, CMAKE Tools je nachdem aktivieren und deaktivieren
          
          shellHook = ''
            echo ""
            echo "🚀 C++ Umgebung gestartet!"
            echo "code ."
            echo ""
          '';
        };

      };

    };
}