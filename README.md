<!--

# TODO:
- make options to make the clock look like Pop2
 - text stroke
 - coloured gradient shadow

-->

<h3 align="center">
 <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/logos/exports/1544x1544_circle.png" width="100" alt="Logo"/><br/>
 <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
 Catppuccin Rounded for <a href="https://github.com/sddm/sddm/">SDDM</a>
 <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/misc/transparent.png" height="30" width="0px"/>
</h3>

<p align="center">
    <a href="https://github.com/Destructor-Ben/sddm-theme/stargazers"><img src="https://img.shields.io/github/stars/Destructor-Ben/sddm-theme?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
    <a href="https://github.com/Destructor-Ben/sddm-theme/issues"><img src="https://img.shields.io/github/issues/Destructor-Ben/sddm-theme?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
    <a href="https://github.com/Destructor-Ben/sddm-theme/contributors"><img src="https://img.shields.io/github/contributors/Destructor-Ben/sddm-theme?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

<p align="center">
  <img src="assets/personal.png"/>
</p>

## Previews

<details>
<summary>🌻 Latte</summary>
<img src="assets/latte.png"/>
</details>
<details>
<summary>🪴 Frappé</summary>
<img src="assets/frappe.png"/>
</details>
<details>
<summary>🌺 Macchiato</summary>
<img src="assets/macchiato.png"/>
</details>
<details>
<summary>🌿 Mocha</summary>
<img src="assets/mocha.png"/>
</details>
<details>
<summary>My Personal Theme</summary>
<img src="assets/personal.png"/>
</details>

## Usage

1. Ensure you have installed the [dependencies](#dependencies) for your operating system.
2. Download your chosen flavour + accent zip file from the [latest GitHub release](https://github.com/Destructor-Ben/sddm-theme/releases/latest).
3. Unzip the file and move the resulting directory to `/usr/share/sddm/themes/`. E.g. to copy `catppuccin-rounded-mocha-mauve`:

    ```bash
    sudo mv -v catppuccin-rounded-mocha-mauve /usr/share/sddm/themes
    ```

4. Edit the `/etc/sddm.conf` file and change the theme to `catppuccin-rounded-<flavour>-<accent>`. For example, `catppuccin-rounded-mocha-mauve`.

   If you don't have this file, create the `/etc/sddm.conf` file and add the following lines:

   ```conf
   [Theme]
   Current=catppuccin-rounded-mocha-mauve
   ```

5. Unfortunately, the theme does not work properly if SDDM is run on X11 and not Wayland - follow the instructions [here](https://wiki.archlinux.org/title/SDDM#Wayland) here if there are issues. 

## Dependencies

### Arch Based OS

```bash
pacman -Syu qt6-svg qt6-declarative qt5-quickcontrols2
```

### Debian Based OS

```bash
apt install --no-install-recommends qml-module-qtquick-layouts qml-module-qtquick-controls2 qml-module-qtquick-window2 libqt6svg6
```

### RPM Based OS

```bash
dnf install qt6-qtquickcontrols2 qt6-qtsvg
```

### Solus OS

```bash
eopkg install qt6-quickcontrols2 qt6-svg
```

### NixOS

This theme can be used with a flake, requiring the flake outputs to be passed via `specialArgs` so config modules can access it. An example flake is shown below.

```nix
{
  description = "Example NixOS SDDM Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    sddm-theme = {
      url = "github:Destructor-Ben/sddm-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, sddm-theme, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    specialArgs = {
      inherit sddm-theme;
    };
  in
  {
    nixosConfigurations = {
      my-computer = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = [
          # Your config modules here...
        ];
      };
    };
  };
}
```

Add the package to `systemPackages` and customize the theme by overriding the args for the package, then set it as the theme in the SDDM configuration.

Note that Nix handles the theme names slightly differently than other distros so you don't have to specify a suffix for the theme name.

```nix
{ pkgs, sddm-theme, ... }:
{
  environment.systemPackages = [
    sddm-theme.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      flavor = "mocha"; # Your preferred flavor
      accent = "mauve"; # Your preferred accent

      # Read the configuration section below to see all of the config options
      # The options specified here should be use the same name used in theme.conf
      # Some example config values are shown below
      options = {
        CustomBackground = true;
        Background = "/home/ben/Pictures/Wallpapers/Galaxy.png";

        Font = "JetBrainsMono Nerd Font Propo";
        ClockFont = "Red Seven";
        Padding = 20;
        LoginButtonHoverColor = "#f5c2e7";
      };
    }

    # If you want to use my personal theme, use:
    # sddm-theme.packages.${pkgs.stdenv.hostPlatform.system}.personal
    # Ensure you have JetBrains Mono Nerd Font and the Red Seven font installed too
  ];

  services.displayManager.sddm = {
    enable = true;;
    theme = "catppuccin-rounded";

    # Other SDDM config options...
  };
}
```

## Configuration

Read through the <a href="templates/theme.tera">config file</a> to see the config options.

The icons default to using power icons and a settings icon from Papirus, which are packaged with the theme.

## 💝 Thanks to

- [DonutDev](https://github.com/DonutDev)
- [Isabelinc](https://github.com/Isabelincorp)
- [Isabel Roses](https://github.com/isabelroses)
- [a9lim](https://github.com/a9lim)

&nbsp;

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>
<p align="center">Copyright &copy; 2021-present <a href="https://github.com/catppuccin" target="_blank">Catppuccin Org</a>
<p align="center">Copyright &copy; 2026-present <a href="https://github.com/catppuccin" target="_blank">Destructor_Ben</a>
<p align="center"><a href="https://github.com/catppuccin/catppuccin/blob/main/LICENSE"><img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=d9e0ee&colorA=363a4f&colorB=b7bdf8"/></a></p>
