{
  description = "My NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    hyprshutdown.url = "github:hyprwm/hyprshutdown/v0.1.0";
    hyprshutdown.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      quest-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs.inputs = inputs;
      };
    };
  };
}
