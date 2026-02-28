IMAGE   := rke2-ansible
TAG     := v1.0
SSH_KEY := $(HOME)/.ssh/Lab/id_ed25519

.PHONY: build run shell clean

build:
	docker build --platform linux/amd64 -t $(IMAGE):$(TAG) .

run: build
	docker run -it --rm \
		-v $(PWD):/workspace \
		-v $(SSH_KEY):/root/.ssh/id_ed25519:ro \
		$(IMAGE):$(TAG)

shell: run

clean:
	docker rmi $(IMAGE):$(TAG)
