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
