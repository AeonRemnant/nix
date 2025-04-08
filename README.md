## Here's my sketchy WIP Nix config, be warned it may break

### Reqs:
1. Systemd boot because it won't work otherwise.
2. Tolerance of my bad docs.

### Using systemd boot
When installing the OS make sure to provision the disk manually, this is because the standard NixOS install puts the boot partition in the root and systemd boot needs an isolated boot partition.
You want at least one gigabyte FAT32 boot partition, this is because NixOS installs generations here. 1GB can hold 5 to 10 generations, I tend to go with 2GB.

Partition should have the boot flag and FAT32 at a minimum, but give it a label.

Make sure you actually install the bootloader in the right partition.


### Actually using the config.
1. Name the user `aeon`.
2. `mkdir -p ~/.config`
3. `sudo nano /etc/nixos/configuration.nix`, add git to `environment.systemPackages`, and enable ssh.
4. `sudo nixos-rebuild switch`
5. `cd ~/.config` -> `git clone https://github.com/aeonremnant/nix`
6. `sudo nixos-rebuild switch --flake ~/.config/nix#forge`
7. Wait for packages to work. 