# RKE2 by 2SpeedLab

### Run playbook
#### Install rke2 cluster
``` 
ansible-playbook site.yml -i inventory.yml
```

#### Install simple cluster (1 master, 2 workers)
Update host IPs in `inventory.simple.yml`, then run:
```
ansible-playbook site.yml -i inventory.simple.yml
```

With a single master, `rke2_ha_mode` is disabled automatically and the API
endpoint uses the master IP instead of kube-vip.

#### Cilium and kube-proxy modes
Set these values in `group_vars/all.yml`:
```
# RKE2 integrated Cilium, or Helm-installed Cilium
cilium_install_method: integrated  # integrated | helm

# Cilium fully replaces kube-proxy
cilium_kubeproxy_mode: replacement

# Keep RKE2 kube-proxy enabled
cilium_kubeproxy_mode: kubeproxy

# Keep kube-proxy enabled and use Cilium partial replacement
cilium_kubeproxy_mode: partial
```

After installed rke2 cluster, disable rke2-ingress and instead of cilium gateway
```
ansible-playbook site.yml -i inventory.yml --tags gateway_api
```

### Remove rke2
``` 
ansible-playbook reset.yml -i inventory.yml
```

### How to usage
1.1 Build docker container <br>
In Makefile, change `SSH_KEY := $(HOME)/.ssh/Lab/id_ed25519` suitable for your ssh key. <br>
Run 
``` 
make build    # build image only
make run      # build + launch container (shell drops you in /workspace)
```
After you run container, run ansible command `ansible-playbook site.yml -i inventory.yml --tags kubeconfig` to get kubeconfig. <br>
Export `export KUBECONFIG=~/.kube/2SpeedLab.yaml` and run this command check connect to cluster
`kgp` <br>

If you want to delete container `make clean`
```

After installed rke2 cluster, disable rke2-ingress and instead of cilium gateway
```
ansible-playbook site.yml -i inventory.yml --tags gateway_api
```

### Remove rke2
``` 
ansible-playbook reset.yml -i inventory.yml
```
