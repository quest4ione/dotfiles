{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "quest-laptop";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.enableAllFirmware = true;

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # TODO: am i using this?
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true; # used by pulseaudio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # search.nixos.org says this is disabled by default...
  services.power-profiles-daemon.enable = false;

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      turbo = "never";
    };
    charger = {
      turbo = "never";
    };
  };

  services.flatpak.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "esc";
          };
        };
      };
    };
  };

  programs.steam.enable = true;
  programs.firefox.enable = true;
  programs.thunderbird.enable = true;

  environment = {
    systemPackages = with pkgs; [
      wget
      helix
      git
      alacritty
      wl-clipboard
    ];
    plasma6.excludePackages = with pkgs.kdePackages; [
      discover
      konsole
      drkonqi
      elisa
      gwenview
      khelpcenter
      kate
      kinfocenter
      okular
      pkgs.xterm
      kmenuedit
    ];
    variables = {
      VISUAL = "hx";
    };
  };

  users.users.quest = {
    isNormalUser = true;
    description = "quest";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
      spotify
      prismlauncher
      osu-lazer-bin
      libreoffice
      numbat
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
