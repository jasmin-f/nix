{
  description = "Android Studio Reverse Engineering Environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { 
      inherit system;
      config.allowUnfree = true;
    };
  in
  {      
    devShells.${system} = rec {
      default = pkgs.mkShell {
        packages = with pkgs; [ 
		android-studio
		ghidra
		jadx
		android-tools
	];
        shellHook = ''
          echo ""
          echo "android-studio, adb, ghidra and jadx"
          echo ""
        '';
      };
    };
  };
}
