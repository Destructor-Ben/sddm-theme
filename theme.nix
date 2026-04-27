{ pkgs, lib, allThemes ? false, flavor ? "mocha", accent ? "mauve" }:
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
      "cp -r themes/ \"$out/share/sddm/\""
      else
      "cp -r themes/catppuccin-rounded-${flavor}-${accent} \"$out/share/sddm/themes/catppuccin-rounded\""
    }

    runHook postInstall
  '';

  meta = {
    description = "Soothing & soft-edged pastel theme for SDDM";
    homepage = "https://github.com/destructor-ben/sddm-theme";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
})

/*

  TODO: allow configuring the config through nix


    configFile=$out/share/sddm/themes/catppuccin-${flavor}-${accent}/theme.conf
    (above goes in install phase)

    substituteInPlace $configFile \
      --replace-fail 'Font="Noto Sans"' 'Font="${font}"' \
      --replace-fail 'FontSize=9' 'FontSize=${fontSize}'

    ${lib.optionalString (background != null) ''
      substituteInPlace $configFile \
        --replace-fail 'Background="backgrounds/wall.png"' 'Background="${background}"'
    ''}

    ${lib.optionalString disableBackground ''
      substituteInPlace $configFile \
        --replace-fail 'CustomBackground="true"' 'CustomBackground="false"'
    ''}

    ${lib.optionalString loginBackground ''
      substituteInPlace $configFile \
        --replace-fail 'LoginBackground="false"' 'LoginBackground="true"'
    ''}

    ${lib.optionalString userIcon ''
      substituteInPlace $configFile \
        --replace-fail 'UserIcon="false"' 'UserIcon="true"'
    ''}

    ${lib.optionalString (!clockEnabled) ''
      substituteInPlace $configFile \
        --replace-fail 'ClockEnabled="true"' 'ClockEnabled="false"'
    ''}
*/
