{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.11";

  outputs = { self, nixpkgs, ... }: {
    # test is a hostname for our machine
    nixosConfigurations = {
      control = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/control ];
      };
      node = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [ ./hosts/node ];
      };
    };
  };
}
