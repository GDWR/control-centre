{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs, ... }: {
    # test is a hostname for our machine
    nixosConfigurations = {
      control = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/control/configuration.nix
        ];
      };
      database = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
	  ./hosts/database/configuration.nix
	];
      };
      node = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
	  ./hosts/node/configuration.nix
	];
      };
    };
  };
}
