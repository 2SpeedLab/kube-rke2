# RKE2 by 2SpeedLab

### Run playbook
#### Install rke2 cluster
``` 
ansible-playbook site.yml -i inventory.yml
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
If you want to delete container `make clean`
