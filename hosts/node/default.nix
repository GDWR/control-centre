{ config, lib, pkgs, ... }:
let
  kubeMasterIP = "172.16.1.1";
  kubeMasterHostname = "api.kube";
  kubeMasterAPIServerPort = 6443;
in
{
  imports = [
    ./vm.nix # Configuration for when using in VM
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking.hostName = "node";
  networking.extraHosts = "${kubeMasterIP} ${kubeMasterHostname}";
  networking.firewall.enable = false;
  networking.interfaces.eth1 = {
    ipv4.addresses = [{
      address = "172.16.1.2";
      prefixLength = 24;
    }];
  };

  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
  ];

  services.kubernetes = let
    api = "https://${kubeMasterHostname}:${toString kubeMasterAPIServerPort}";
  in
  {
    roles = ["node"];
    masterAddress = kubeMasterHostname;
    easyCerts = true;

    # point kubelet and other services to kube-apiserver
    kubelet.kubeconfig.server = api;
    apiserverAddress = api;

    # use coredns
    addons.dns.enable = true;

    # needed if you use swap
    kubelet.extraOpts = "--fail-swap-on=false";
  };

  system.stateVersion = "23.11";
}
