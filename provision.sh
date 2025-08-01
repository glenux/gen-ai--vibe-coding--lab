#!/bin/sh

set -e
set -u

## TODO
# install KiloCode + Cline + Goose + Claude Code + Aider.Chat + Crush

# Setup settings
ASDF_VERSION="v0.13.1"
DIRENV_VERSION="2.32.3"

USER="$(test -d /vagrant && echo "vagrant" || echo "debian")"
HOSTNAME="$(hostname)"

# OS_ID="$(cat /etc/os-release | awk -F= '/^ID=/{print $2}' | tr -d '"')"
# OS_VERSION="$(cat /etc/os-release | awk -F= '/^VERSION_ID=/{print $2}' | tr -d '"')"

export DEBIAN_FRONTEND=noninteractive
apt-get update --allow-releaseinfo-change
apt-get install -y \
   apt-transport-https \
   ca-certificates \
   python3-pip \
   git unzip \
   curl wget \
   vim nano \
   graphviz \
   gnupg2 \
   fzf \
   npm \
   software-properties-common

# Installing asdf
su - "$USER" -c "rm -rf ~/.asdf"
su - "$USER" -c "git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch '$ASDF_VERSION'"
su - "$USER" -c "echo '. \$HOME/.asdf/asdf.sh' >> ~/.bashrc"

## # Installing direnv
su - "$USER" -c "source \$HOME/.asdf/asdf.sh && asdf plugin add direnv"
su - "$USER" -c "source \$HOME/.asdf/asdf.sh && asdf install direnv '$TERRAFORM_VERSION'"
su - "$USER" -c "source \$HOME/.asdf/asdf.sh && asdf global direnv '$TERRAFORM_VERSION'"

# Configuring direnv
tmpconfig="$(mktemp)"
cat > "$tmpconfig" <<-MARK
[global]
load_dotenv = true
strict_env = true
MARK
mkdir -p "/home/$USER/.config/direnv/"
mv "$tmpconfig" "/home/$USER/.config/direnv/direnv.toml"
chown -R "$USER:$USER" "/home/$USER/.config/direnv"

# Configure vim for terraform
cat > "/home/$USER/.vimrc" <<MARK
execute pathogen#infect()
syntax on
filetype plugin indent on
MARK
chown -R "$USER:$USER" "/home/$USER/.vimrc"

# Configure PATH for local binaries
if ! greq -q "export PATH=\$PATH:~/.local/bin" "/home/$USER/.bashrc" ; then
	su - "$USER" -c "echo \"export PATH=\$PATH:~/.local/bin\" >> /home/$USER/.bashrc"
fi

# Install IA & Vibe Coding tools
#
sudo npm install -g @anthropic-ai/claude-code
sudo npm install -g @charmland/crush

# su - "$USER" -c "code-server --install-extension kilocode.Kilo-Code"
# su - "$USER" -c "code-server --install-extension saoudrizwan.claude-dev"
su - "$USER" -c "curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | CONFIGURE=false bash"

su - "$USER" -c "python -m pip install --break-system-packages aider-install"
su - "$USER" -c "aider-install"

echo "SUCCESS"

