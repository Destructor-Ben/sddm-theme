{
  description = "Soothing & soft-edged pastel theme for SDDM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        themePkg = pkgs.callPackage ./theme.nix { };

        testScript = pkgs.writeShellScriptBin "test-theme" ''
          export QML2_IMPORT_PATH="${with pkgs.kdePackages; pkgs.lib.makeSearchPath "lib/qt-6/qml" [
            qt5compat
            qtsvg
            sddm
          ]}"

          FLAVOR=''${1:-"mocha"}
          ACCENT=''${2:-"mauve"}
          ${pkgs.kdePackages.sddm}/bin/sddm-greeter-qt6 --test-mode --theme ${themePkg.override { allThemes = true; }}/share/sddm/themes/catppuccin-rounded-$FLAVOR-$ACCENT
        '';
      in {
        apps.default = {
          type = "app";
          program = "${testScript}/bin/test-theme";
        };

        packages.default = themePkg;
      });
}
