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
            # google-chrome
            # google-chrome-stable
            # ungoogled-chromium
          ];
          shellHook = ''
            echo ""
            echo "webstorm ."
            echo ""
            # npm install <package>
            export PATH="$PWD/node_modules/.bin/:$PATH"
            export NPM_PACKAGES="$HOME/.npm-packages"
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
            echo "hier nur .NET für eine einfache Benuztung"
            echo "starte .NET auf Windows und entferne die direnv Datei."
            echo ""
          '';
        };

        # nix develop .#cplus (C++)
        cplus = pkgs.mkShell {
          packages = with pkgs; [ 
            (openssl.override { static = true; })
            # C++ Compiler is already part of stdenv
            #boost 
            #catch2 # in cmakelist schon intergriert
            cmake #build generator
            ninja # build tool (ninja oder make nötig)
            rocmPackages.clang
          ];
            
          # vs code extensions:
            # - C/C++ (intellisense und mehr)
            # - CMake Tools
            # kein clangd!
            # intellisense von vscode deaktivieren, wegen Konflikt, keine Code-Vorschläge 
          # Ordner ~/wsl-code/ost_3_semester/cpl öffnen. 

          # bei build mit "play button" auswählen wo ich arbeite.
          # Status Bar unten enthält viele Optionen, CMAKE Tools je nachdem aktivieren und deaktivieren
          # ctrl+shift+f5 um das ausgewählte target laufen zu lassen (wie mit dem play button) 
          
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
            # clang-manpages geht nicht
          ];
          shellHook = ''
            printf '\nEntwicklungsumgebung für Assembler \n\n'
          '';
        };
        


        # TODO: man clang
        # nix develop .#bsys1-manual
        bsys1-manual = pkgs.mkShell {
          packages = with pkgs; [ 
            nasm

            llvmPackages_21.libcxxClang
            # clang-wrapper

            # llvmPackages_21.clang-unwrapped

            #llvmPackages_21.clang-manpages
            # clang-manpages

            clang-manpages
          ];
          shellHook = ''
            printf '\nEntwicklungsumgebung für Assembler \n\n'
          '';
        };

        # nix develop .#bsys1-static
        bsys1-static = pkgs.mkShell {
          packages = with pkgs; [ 
            nasm
            clang # C Compiler des LLVM-Projekts
            # damit clang -static unterstützt wird, diese library einbinden. Jedoch circular dependency Problem bei printf von C Datei.
            glibc.static

          ];
          shellHook = ''
            printf '\nEntwicklungsumgebung für Assembler\n'
            printf '-static unterstützt\n\n"
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
            # texlive.combined.scheme-medium
            texlive.combined.scheme-small
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