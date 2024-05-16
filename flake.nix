{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = import ./hosts { pkgs = nixpkgs; };
  };
}
