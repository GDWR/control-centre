{ config, ... }: {
  config = {
    virtualisation.vmVariant = {
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
  };
}
