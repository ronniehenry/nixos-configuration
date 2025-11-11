# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define the hostname.
  networking.hostName = "osiris";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_PH.UTF-8";
    LC_IDENTIFICATION = "en_PH.UTF-8";
    LC_MEASUREMENT = "en_PH.UTF-8";
    LC_MONETARY = "en_PH.UTF-8";
    LC_NAME = "en_PH.UTF-8";
    LC_NUMERIC = "en_PH.UTF-8";
    LC_PAPER = "en_PH.UTF-8";
    LC_TELEPHONE = "en_PH.UTF-8";
    LC_TIME = "en_PH.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rah = {
    isNormalUser = true;
    description = "Ronnie Henry";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  add pkgs here
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [

    # properly get files from the web
    wget
    curl
    
    # for development/configuration management
    git

    # manage appimages
    gearlever

    # torrent client
    transmission_4-gtk

    # a better terminal
    ghostty

    # make that dcp t720dw printer work
    cups-brother-dcpt725dw
    brscan5

    # best browser for Linux
    firefox

    # editors/IDE, note that nano is installed by default
    neovim
    arduino-ide
    jetbrains.pycharm-community-bin

    # GNU development tools
    gnumake
    gcc
    gdb

    # Python interpreter
    python314Full
    
    # change the GNOME look and behaviour 
    gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.paperwm
    gnomeExtensions.dash-to-dock
    gnomeExtensions.arcmenu
    bibata-cursors
    papirus-icon-theme

    # nice to have
    fastfetch
    btop
    bash-completion
    ripgrep
    fd
    zip
    unzip

    # fonts, why not?
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    liberation_ttf
    font-awesome
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Keep this NixOS system up-to-date automatically
  # Enables a periodically executed systemd service named nixos-upgrade.service
  # If allowReboot is true, then the system will automatically reboot
  # if the new generation contains a different kernel, initrd or kernel modules.
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Enable AppImage support.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
