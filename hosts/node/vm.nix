{ config, ... }: {
  config = {
    virtualisation.vmVariant = {
      # following configuration is added only when building VM with build-vm
      virtualisation = {
        memorySize = 4096;
        diskSize = 8192;
        cores = 2;
        graphics = false;
        qemu.networkingOptions = [
          "-net nic,id=eth1,model=e1000"
          "-net socket,connect=localhost:8765"
        ];
      };
    };
  };
}
