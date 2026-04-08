{
  description = "C und Assembler, normal und mit -static";

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
            gdb
          ];

          # man nasm war verfügbar, man clang nicht
          shellHook = ''
            printf '\nEntwicklungsumgebung für Assembler \n'
            export MANPATH="/nix/store/lqdpgi6zs1wvc4490cpw8nbj34n5wv4h-clang-manpages-21.1.0/share/man/:''${MANPATH:-:}"
            echo 'man clang funktioniert' 
            echo '-'
          '';

          # nicht escaped version:
          # export MANPATH="/nix/store/wi30i30p28sckk88dgcqh3v0n0nn3lkv-clang-manpages-19.1.7/share/man/:${MANPATH:-:}"

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