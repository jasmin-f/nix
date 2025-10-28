{
  description = "Alle Studium Dev-Environments";

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

        # nix develop standard packages
        default = pkgs.mkShell {
          packages = [  ];
        };

        # nix develop .#web1 (WE1)
        web1 = pkgs.mkShell {
          packages = with pkgs; 
          [ 
            jetbrains.webstorm 
            firefox 
            nodejs 
          ];

          shellHook = ''
            echo ""
            echo "webstorm ."
            echo ""
          '';
        };

        # nix develop .#dotnet (.NET) 
        dotnet = pkgs.mkShell {
          packages = with pkgs; [ 
            jetbrains.rider 
            dotnetCorePackages.sdk_8_0_3xx-bin 
          ];

          shellHook = ''
            echo ""
            echo "C#"
            echo "rider ."
            echo ""
          '';
        };

        # nix develop .#cplus (C++)
        cplus = pkgs.mkShell {
          packages = with pkgs; [ 
            # C++ Compiler is already part of stdenv
            #boost 
            #catch2 # in cmakelist schon intergriert
            cmake #build generator
            ninja # build tool (ninja oder make nötig)
            rocmPackages.clang
            
            # vs code extensions:
              # - C/C++ (intellisense und mehr)
              # - CMake Tools
              # kein clangd!
            # Ordner ~/wsl-code/ost_3_semester/cpl öffnen. 

            # bei build mit "play button" auswählen wo ich arbeite.
            # Status Bar unten enthält viele Optionen, CMAKE Tools je nachdem aktivieren und deaktivieren

          ];
          shellHook = ''
            echo ""
            echo "🚀 C++ Umgebung gestartet!"
            echo "code ."
            echo ""
          '';
        };

        # nix develop .#bsys1
        bsys1 = pkgs.mkShell {
          packages = with pkgs; [ 
            nasm
            clang # C Compiler des LLVM-Projekts

            # damit clang -static funktioniert diese library einbinden:
            glibc.static
          ];
          shellHook = ''
            echo ""
            echo "Entwicklungsumgebung für Assembler"
            code .
            echo ""
          '';
        };

        # nix develop .#uml
        uml = pkgs.mkShell {
          packages = with pkgs; [ 
            # umlet
            plantuml # server
          ];
          shellHook = ''
            code .
            echo ""
            plantuml
            echo ""
          '';
        };

        # java for console
        # nix develop .#java
        java = pkgs.mkShell {
          packages = with pkgs; [
            jdk
            maven
          ];
        };

        # Latex
        # nix develop .#latex
        latex = pkgs.mkShell {
          packages = with pkgs; [
            texlive.combined.scheme-medium
          ];
        };

        # ----------------------- ----------------- -----
        #    Privat
        # ----------------------- ----------------- -----

        # Portfolio Website
        firebase = pkgs.mkShell {
          packages = with pkgs; [
            firebase-tools
          ];
        };

      };

    };
}