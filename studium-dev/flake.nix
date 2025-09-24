{
  description = "Alle Studium Dev-Environments";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
  
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;  # for webstorm
      };

    in
    {      
      
      devShells.${system} = rec {
        # nix develop
        default = pkgs.mkShell {
          packages = [ pkgs.nodejs pkgs.jetbrains.webstorm pkgs.firefox ];
        };

        # nix develop .#web (WE1)
        web = pkgs.mkShell {
          packages = [ pkgs.jetbrains.webstorm pkgs.firefox pkgs.nodejs ];
        };

        # nix develop .#dotnet (.NET) 
        dotnet = pkgs.mkShell {
          packages = [ pkgs.jetbrains.rider pkgs.dotnetCorePackages.sdk_8_0_3xx-bin ];
        };

        # nix develop .#cplus (C++)
        cplus = pkgs.mkShell {
          packages = with pkgs; [ 
            # C++ Compiler is already part of stdenv
            #boost
            #catch2
            cmake #build
            ninja # für performance?
          ];
        };

        # nix develop .#bsys1
        bsys1 = pkgs.mkShell {
          packages = with pkgs; [ 
            nasm
            rocmPackages.llvm.clang-unwrapped # clang #C Compiler des LLVM-Projekts: apt install clang
          ];
        };

      };

    };
}

# C++
# https://nixcademy.com/posts/cpp-with-nix-in-2023-part-1-shell/
# $ which c++
# /nix/store/zlzz2z48s7ry0hkl55xiqp5a73b4mzrg-gcc-wrapper-12.3.0/bin/c++

# $ which cmake
# /nix/store/5h0akwq4cwlc3yp92i84nfgcxpv5xv79-cmake-3.26.4/bin/cmake
# unfree: https://stackoverflow.com/questions/77585228/how-to-allow-unfree-packages-in-nix-for-each-situation-nixos-nix-nix-wit