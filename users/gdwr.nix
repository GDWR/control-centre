{ config, pkgs, ... }: {
  config = {
    users.users = {
      gdwr = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        password = "gdwr";
        group = "admin";
      };
    };
  };
}
