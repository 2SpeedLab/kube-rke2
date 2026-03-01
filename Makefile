IMAGE   := rke2-ansible
TAG     := v1.0
SSH_KEY := $(HOME)/.ssh/Lab/id_ed25519
KUBE_DIR := $(HOME)/.kube

.PHONY: build run shell kubeconfig clean

build:
	docker build --platform linux/amd64 -t $(IMAGE):$(TAG) .

run: build
	docker run -it --rm \
		--platform linux/amd64 \
		-v $(PWD):/workspace \
		-v $(SSH_KEY):/root/.ssh/key:ro \
		-v $(KUBE_DIR):/root/.kube \
		-w /workspace \
		$(IMAGE):$(TAG)

kubeconfig: build
	mkdir -p $(KUBE_DIR)
	docker run --rm \
		--platform linux/amd64 \
		-v $(PWD):/workspace \
		-v $(SSH_KEY):/root/.ssh/key:ro \
		-v $(KUBE_DIR):/root/.kube \
		-w /workspace \
		$(IMAGE):$(TAG) \
		ansible-playbook site.yml -i inventory.yml --tags kubeconfig
	@echo "Kubeconfig saved to $(KUBE_DIR)/2SpeedLab.yaml"
	@echo "Use: export KUBECONFIG=$(KUBE_DIR)/2SpeedLab.yaml"

shell: run

clean:
	docker rmi $(IMAGE):$(TAG)
