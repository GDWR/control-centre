{ config, pkgs, ... }: {
  config = {
    users.users = {
      admin = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        password = "admin";
        group = "admin";
      };
    };
  };
}
