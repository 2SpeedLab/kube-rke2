IMAGE   := rke2-ansible
TAG     := v1.0
SSH_KEY := $(HOME)/.ssh/key
KUBE_DIR := $(HOME)/.kube

.PHONY: build run shell clean

build:
	docker build --platform linux/amd64 -t $(IMAGE):$(TAG) .

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


shell: run

clean:
	docker rmi $(IMAGE):$(TAG)
