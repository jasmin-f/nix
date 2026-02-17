{
  description = "Dev Environment für Web Engineering 1 (mit Webstorms, natürlich kann auch VS Code genutzt werden)";

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
          config.allowUnfree = true;  # for webstorm license
          overlays = [ inputs.self.overlays.default ];
        };
      }
    );
  in
  {      
    devShells.${system} = rec {
      default = pkgs.mkShell {
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
    };
  };
}