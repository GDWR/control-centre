{ config, lib, pkgs, ... }: 
let
  kubeMasterIP = "172.16.1.1";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
in
{

  users.groups.admin = {};
  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "admin";
      group = "admin";
    };
  };


  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; 
      diskSize = 8192;
      cores = 2;
      graphics = false;
      forwardPorts = [ 
        { from = "host"; host.port = 2222; guest.port = 22; }
      ];
      qemu.networkingOptions = [
	"-net nic,id=eth1,model=e1000"
	"-net socket,listen=localhost:8765"
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking.hostName = "control";
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";
  networking.firewall.enable = false;
  networking.interfaces.eth1 = {
    ipv4.addresses = [{
      address = "172.16.1.1";
      prefixLength = 24;
    }];
  };

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = kubeMasterHostname;
    apiserverAddress = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
    easyCerts = true;
    apiserver = {
      securePort = kubeMasterAPIServerPort;
      advertiseAddress = kubeMasterIP;
    };

    # use coredns
    addons.dns.enable = true;

    # needed if you use swap
    kubelet.extraOpts = "--fail-swap-on=false";
  };

  system.stateVersion = "23.11";
}
