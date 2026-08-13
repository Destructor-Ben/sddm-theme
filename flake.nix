{
  description = "Soothing & soft-edged pastel theme for SDDM";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        theme-package = pkgs.callPackage ./theme.nix { };

        test-script = pkgs.writeShellScriptBin "test-theme" ''
          export QML2_IMPORT_PATH="${
            with pkgs.kdePackages;
            pkgs.lib.makeSearchPath "lib/qt-6/qml" [
              qt5compat
              qtsvg
              sddm
            ]
          }"

          # Fixes wrong bit depth being used
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=0

          FLAVOR=''${1:-"mocha"}
          ACCENT=''${2:-"mauve"}
          ${pkgs.kdePackages.sddm}/bin/sddm-greeter-qt6 --test-mode --theme ${
            theme-package.override { allThemes = true; }
          }/share/sddm/themes/catppuccin-rounded-$FLAVOR-$ACCENT
        '';

        test-personal-script = pkgs.writeShellScriptBin "test-personal-theme" ''
          export QML2_IMPORT_PATH="${
            with pkgs.kdePackages;
            pkgs.lib.makeSearchPath "lib/qt-6/qml" [
              qt5compat
              qtsvg
              sddm
            ]
          }"

          # Fixes wrong bit depth being used
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=0

          ${pkgs.kdePackages.sddm}/bin/sddm-greeter-qt6 --test-mode --theme ${
            theme-package.override (import ./personal-theme.nix)
          }/share/sddm/themes/catppuccin-rounded
        '';
      in
      {
        apps.default = {
          type = "app";
          program = "${test-script}/bin/test-theme";
        };

        apps.test-personal = {
          type = "app";
          program = "${test-personal-script}/bin/test-personal-theme";
        };

        packages.default = theme-package;
        packages.personal = theme-package.override (import ./personal-theme.nix);

        formatter = pkgs.nixfmt-tree;
      }
    );
}
