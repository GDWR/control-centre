{ config, ... }: {
  imports = [
    ./gdwr.nix
  ];

  config = {
    users.groups.admin = {};
  };
}
