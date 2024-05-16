{ pkgs, ... }: {
  control = pkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ./control ../users ];
  };

  node = pkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ ./node ../users ];
  };
}
