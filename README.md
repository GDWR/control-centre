Infra
=====


Quick start
-----------
```bash
# Run control host
nix run .#nixosConfigurations.control.config.system.build.vm

# Run node host
nix run .#nixosConfigurations.node.config.system.build.vm
```

Once both are running, in the control host, you can run:
```bash
[admin@control:~]$ sudo cp /etc/kubernetes/cluster-admin.kubeconfig /root/.kube/config
[admin@control:~]$ sudo kubectl get nodes
[admin@control:~]$ sudo cat /var/lib/kubernetes/secrets/apitoken.secret # this is TOKEN

[admin@node:~]$ echo TOKEN | sudo nixos-kubernetes-node-join

[admin@control:~]$ sudo kubectl get nodes # Validate node is joined
```

