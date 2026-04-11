#!/usr/bin/env bash

just build
sddm-greeter-qt6 --test-mode --theme themes/catppuccin-mocha-mauve
