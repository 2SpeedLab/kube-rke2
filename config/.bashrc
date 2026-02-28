# Path to oh-my-bash installation
export OSH='/root/.oh-my-bash'

# Theme
OSH_THEME="axin"

# Timestamps in history
HIST_STAMPS='dd.mm.yyyy'

# Plugins
completions=(
  git
  ssh
  kubectl
  helm
  ansible
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

source "$OSH"/oh-my-bash.sh

# Kubectl shortcuts
alias k='kubectl'
alias kgp='kubectl get pods -A'
alias kgn='kubectl get nodes -o wide'
alias kns='kubectl config set-context --current --namespace'

# Ansible shortcuts
alias ap='ansible-playbook'
alias api='ansible-playbook site.yml -i inventory.yml'

# Helm shortcuts
alias h='helm'

# Workspace
export KUBECONFIG=/root/.kube/config
