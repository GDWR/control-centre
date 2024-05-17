{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs, ... }: let
    hosts = [ control node ];

    control = {
      system = "x86_64-linux";
      modules = [ ./hosts/control ./users ];
    };

    node = {
      system = "x86_64-linux";
      modules = [ ./hosts/node ./users ];
    };

  in {
    nixosConfigurations = {
      control = nixpkgs.lib.nixosSystem control;
      node = nixpkgs.lib.nixosSystem node;
    };
  };
}
