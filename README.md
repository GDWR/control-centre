# Infra

Quick start

```bash
# Run control host
nix run .#nixosConfigurations.control.config.system.build.vm

# Run node host
nix run .#nixosConfigurations.node.config.system.build.vm
```
