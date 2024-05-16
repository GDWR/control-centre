{ config, ... }: {
  imports = [
    ./admin.nix
    ./gdwr.nix
  ];

  config = {
    users.groups.admin = {};
  };
}
