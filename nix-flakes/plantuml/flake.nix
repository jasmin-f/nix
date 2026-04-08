{
  description = "Plantuml Diagramme erstellen mit Text (Alternative Mermaidjs oder Typst/pintorita)";

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
          # umlet
          plantuml # server
          # mermaid-cli
        ];
        shellHook = ''
          echo "plantuml oder mmdc"
          echo ""
        '';
      };
    };
  };
}