IMAGE   := rke2-ansible
TAG     := v1.0
SSH_KEY := $(HOME)/.ssh/key
KUBE_DIR := $(HOME)/.kube
PLAYBOOK ?= site.yml
INVENTORY ?= inventory.yml
ANSIBLE_ARGS ?=

.PHONY: build env run shell new-cluster cluster clean

build:
	docker build --platform linux/amd64 -t $(IMAGE):$(TAG) .

env: build
	mkdir -p $(KUBE_DIR)
	docker run -it --rm \
	--platform linux/amd64 \
	-v $(PWD):/workspace \
	-v $(SSH_KEY):/root/.ssh/key:ro \
	-v $(KUBE_DIR):/root/.kube \
	-w /workspace \
	$(IMAGE):$(TAG) \
	bash

run: build
	mkdir -p $(KUBE_DIR)
	docker run -it --rm \
	--platform linux/amd64 \
	-v $(PWD):/workspace \
	-v $(SSH_KEY):/root/.ssh/key:ro \
	-v $(KUBE_DIR):/root/.kube \
	-w /workspace \
	$(IMAGE):$(TAG) \
	bash -c "ansible-playbook site.yml -i inventory.yml --tags kubeconfig; exec bash"


shell: env

new-cluster: build
	mkdir -p $(KUBE_DIR)
	docker run -it --rm \
	--platform linux/amd64 \
	-v $(PWD):/workspace \
	-v $(SSH_KEY):/root/.ssh/key:ro \
	-v $(KUBE_DIR):/root/.kube \
	-w /workspace \
	$(IMAGE):$(TAG) \
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) $(ANSIBLE_ARGS)

cluster: new-cluster

clean:
	docker rmi $(IMAGE):$(TAG)
