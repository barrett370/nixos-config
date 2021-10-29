# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "nix_tower"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless.

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/London";

  environment.variables = {
    EDITOR = "vim";
  };

  environment.systemPackages = with pkgs; [
    wget
    vim                                # Text editor
    rxvt_unicode                       # Terminal emulator
    dmenu                              # Application launcher
    xclip                              # Clipboard command line util
    compton                            # Windowing system for niceness
    xlibs.xmodmap                      # Keyboard reconfiguration
    tmux                               # Console multiplexer
    htop                               # System monitor
    ffmpeg
    mplayer                            # Video player

    unzip                              # .zip file util
    font-awesome-ttf                   # Font awesome TTF font for bar
  ];
  programs.zsh.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enableTCP = false;
    exportConfiguration = false;
    enable = true;
    layout = "us";

    desktopManager = {
      xterm.enable = false;
      xfce.enable = false;
    };

    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      default = "xmonad";
    };
  };
  
  
  users.extraUsers.sam = {
    isNormalUser = true;
    home = "/home/sam";
    extraGroups = ["wheel" "networkmanager" "video"];
    uid = 1000;
  };

  fonts = {
    enableFontDir = true; 
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      ubuntu_font_family # Ubuntu fonts
      liberation_ttf 
      fira-code
      fira-mono
      fira-code-symbols
    ];
  };
}

