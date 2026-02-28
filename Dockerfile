FROM --platform=linux/amd64 python:3.14.3-slim-bookworm

ARG KUBECTL_VERSION=v1.32.2
ARG HELM_VERSION=v3.17.1

ENV DEBIAN_FRONTEND=noninteractive

# Base packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    openssh-client \
    sshpass \
    bash \
    jq \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    ansible-core==2.20.2 \
    jinja2==3.1.6

RUN ansible-galaxy collection install community.general

# Install kubectl
RUN curl -fsSL https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    | tar -xz -C /usr/local/bin --strip-components=1 linux-amd64/helm \
    && chmod +x /usr/local/bin/helm

# Install oh-my-bash
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

COPY config/.bashrc /root/.bashrc
COPY config/.vimrc  /root/.vimrc

WORKDIR /workspace

CMD ["bash"]
