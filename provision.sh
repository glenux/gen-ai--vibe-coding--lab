#!/usr/bin/env bash

set -eu
set -o pipefail

# Configuration settings
ASDF_VERSION="v0.13.1"
DIRENV_VERSION="2.32.3"
# CODE_SERVER_VERSION="4.91.1"

USER="$(test -d /vagrant && echo "vagrant" || echo "debian")"
HOSTNAME="$(hostname)"

##
## System update and base packages
##

export DEBIAN_FRONTEND=noninteractive
apt-get update --allow-releaseinfo-change
apt-get install -y \
   apt-transport-https \
   ca-certificates \
   python3-pip \
   python-is-python3 \
   git unzip \
   curl wget \
   vim nano \
   graphviz \
   gnupg2 \
   fzf \
   npm \
   software-properties-common

##
## Installing asdf version manager
##
su - "$USER" -c "rm -rf ~/.asdf"
su - "$USER" -c "git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch '$ASDF_VERSION'"
su - "$USER" -c "echo '. \$HOME/.asdf/asdf.sh' >> ~/.bashrc"

##
## Installing direnv
##
# Using asdf to install direnv
su - "$USER" -c "source \$HOME/.asdf/asdf.sh && asdf plugin add direnv"
su - "$USER" -c "source \$HOME/.asdf/asdf.sh && asdf install direnv '$DIRENV_VERSION'"
su - "$USER" -c "source \$HOME/.asdf/asdf.sh && asdf global direnv '$DIRENV_VERSION'"

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

##
## Define sane settings for system
##

# Configure vim
cat > "/home/$USER/.vimrc" <<MARK
execute pathogen#infect()
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
MARK
chown -R "$USER:$USER" "/home/$USER/.vimrc"

# Configure PATH for local binaries
if ! grep -q "export PATH=\$PATH:~/.local/bin" "/home/$USER/.bashrc" ; then
	su - "$USER" -c "echo '' >> /home/$USER/.bashrc"
	su - "$USER" -c "echo '# Add local binaries to PATH' >> /home/$USER/.bashrc"
	su - "$USER" -c "echo 'export PATH=\$PATH:~/.local/bin' >> /home/$USER/.bashrc"
fi

# TODO: add API keys to bashrc
# export GEMINI_API_KEY="YOUR_API_KEY"
# export GOOGLE_API_KEY="YOUR_API_KEY"
# export GOOGLE_GENAI_USE_VERTEXAI=true
# export OPENAI_API_KEY="your-api-key-here"

##
## Install IA & Vibe Coding tools
##

# Install Claude Code
npm install -g @anthropic-ai/claude-code

# Install Crush
npm install -g @charmland/crush

# Install Gemini CLI
# Ref. https://github.com/google-gemini/gemini-cli
npm install -g @google/gemini-cli

# Install OpenAI Codex
# Ref. https://github.com/openai/codex
npm install -g @openai/codex

# Install MyCoder
# Ref. https://github.com/drivecore/mycoder
npm install -g mycoder

# TODO: install Dyad
# Ref. https://www.dyad.sh/


# Install Goose
su - "$USER" -c "curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | CONFIGURE=false bash"

# Install Aider.Chat
# (Use --break-system-packages for Debian 12 compatibility)
su - "$USER" -c "python -m pip install --break-system-packages aider-chat"



##
## Install and Configure code-server (VS Code in the browser)
##
if ! [ -f /usr/bin/code-server ]; then
	curl -fsSL https://code-server.dev/install.sh | sh
fi

mkdir -p "/home/$USER/.config/code-server/"
cat > "/home/$USER/.config/code-server/config.yaml" <<MARK
bind-addr: 0.0.0.0:8080
auth: password
password: vagrant
cert: false
MARK
chown -R "$USER:$USER" "/home/$USER/.config/code-server/"

systemctl daemon-reload
systemctl enable --now "code-server@$USER"
systemctl start "code-server@$USER"

su - "$USER" -c "code-server --install-extension kilocode.Kilo-Code"
su - "$USER" -c "code-server --install-extension saoudrizwan.claude-dev"

# Install Continue
# Ref. https://github.com/continuedev/continue
su - "$USER" -c "code-server --install-extension Continue.continue"

# TODO: Install SuperDesign
# Ref. https://www.superdesign.dev/

systemctl restart "code-server@$USER"

echo ""
echo ">>> Provisioning Complete! <<<"
echo "Access the lab in your browser at http://localhost:8080"
echo "Or connect via terminal with 'vagrant ssh'"
echo "SUCCESS"

