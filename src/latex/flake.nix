{
  description = "Latex";

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