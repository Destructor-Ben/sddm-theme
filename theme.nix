{
  pkgs,
  lib,
  allThemes ? false,
  flavor ? "mocha",
  accent ? "mauve",
  options ? { },
}:
pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "catppuccin-sddm-rounded";
  version = "0.1";

  src = ./.;

  dontWrapQtApps = true;

  nativeBuildInputs = with pkgs; [
    just
    catppuccin-whiskers
  ];

  propagatedBuildInputs = with pkgs; [
    kdePackages.qtbase
    kdePackages.qtsvg
    kdePackages.qt5compat
  ];

  postPatch = ''
    substituteInPlace justfile \
      --replace-fail '#!/usr/bin/env bash' '#!${lib.getExe pkgs.bash}'
  '';

  buildPhase = ''
    runHook preBuild

    just build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    ${
      if allThemes then
        ''
          cp -r themes/ "$out/share/sddm/"
          configFiles=$(find "$out/share/sddm/themes/" -name "theme.conf")
        ''
      else
        ''
          cp -r themes/catppuccin-rounded-${flavor}-${accent} "$out/share/sddm/themes/catppuccin-rounded"
          configFiles=$out/share/sddm/themes/catppuccin-rounded/theme.conf;
        ''
    }

    for configFile in $configFiles; do
      echo "Applying configuration to $configFile..."

      ${lib.concatStringsSep "\n" (
        lib.mapAttrsToList (
          key: value:
          let
            safe-value = if builtins.isBool value then lib.boolToString value else toString value;
          in
          ''sed -i "s|^[[:space:]]*${key}=.*|${key}=${safe-value}|" "$configFile"''
        ) options
      )}
    done

    runHook postInstall
  '';

  meta = {
    description = "Soothing & soft-edged pastel theme for SDDM";
    homepage = "https://github.com/destructor-ben/sddm-theme";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})
