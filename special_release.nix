# release.nix
{ nixpkgs ? <nixpkgs> }:
let
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  nixos = import "${nixpkgs}/nixos";
  configuration = {
    imports = [
      "${nixpkgs}/nixos/maintainers/scripts/ec2/amazon-image.nix"
    ];
    ec2.hvm = true; # Ensure HVM virtualization for EC2
    nixpkgs.hostPlatform = "x86_64-linux";
    # Optional: Add custom configurations
    services.sshd.enable = true;
    environment.systemPackages = with pkgs; [ git vim ];
  };
in {
  amazonImage = (nixos { configuration = configuration; }).config.system.build.amazonImage;
}