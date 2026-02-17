{
  description = "C + Assembler, normal und mit -static";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  # outputs = { self, nixpkgs } : 
  outputs = { nixpkgs, ... } :
    let
      # systems = nixpkgs.lib.platforms.unix;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config = { };
              overlays = [ ];
            }
          )
        );
  in {
      devShells = eachSystem (pkgs: {
        # mkShellNoCC statt mkShell "is simply an alias for nativeBuildInputs. produces such an environment, but without a compiler toolchain."" https://nix.dev/tutorials/first-steps/declarative-shell.html

        default = pkgs.mkShell {
          packages = with pkgs; [ 
            nasm
            clang
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

      });

  };
}