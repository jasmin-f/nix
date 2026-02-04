{
  description = "Latex";

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
          # minimale Version mit latex pdf export funktion
          texlive.combined.scheme-small

          # # für SEP1 mit latexmk command:
          # latexrun
          # texliveFull
        ];
      };

      
      full-latex = pkgs.mkShellNoCC {
        packages = with pkgs; [
          latexrun
          texliveFull
        ];
        # - installiere auch das latex workshop vscode plugin
      };

      
    };
  };
}