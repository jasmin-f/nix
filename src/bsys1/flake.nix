{
  description = "C + Assembler, normal und mit -static";

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
        # nix develop
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
    };
  };
}