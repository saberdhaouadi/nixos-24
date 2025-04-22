# release.nix
{ nixpkgs ? <nixpkgs> }:
let
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  nixos = import "${nixpkgs}/nixos";
  configuration = {
    # Minimal EC2 configuration
    imports = [
      "${nixpkgs}/nixos/maintainers/scripts/ec2/amazon-image.nix"
    ];
    nixpkgs.hostPlatform = "x86_64-linux";
    # Optional: Add custom configurations
    services.sshd.enable = true;
    environment.systemPackages = with pkgs; [ git vim ];
 };
in {
  amazonImage = (nixos { configuration = configuration; }).config.system.build.amazonImage;
}


