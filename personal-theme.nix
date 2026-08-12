{
  flavor = "mocha";
  accent = "mauve";

  options = rec {
    CustomBackground = true;
    Background="backgrounds/julia.png";

    Font = "JetBrainsMono Nerd Font Propo";
    ClockFont = "Red Seven";
    ClockTimeFormat = "HH:mm";

    Padding = 20;
    ClockTopMargin = 50;
    LoginButtonHoverColor = "#f5c2e7";
    LoginButtonPressedColor = LoginButtonHoverColor;
  };
}
