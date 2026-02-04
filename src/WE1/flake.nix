{
  description = "Dev Environment für Web Engineering 1";

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