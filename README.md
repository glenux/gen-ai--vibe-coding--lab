
[![Build Status](https://cicd.apps.glenux.net/api/badges/glenux/mfm/status.svg)](https://cicd.apps.glenux.net/glenux/gen-ai--vibe-coding--lab)
![License BSD-3](https://img.shields.io/badge/license-BSD-3.svg)
[![Donate on patreon](https://img.shields.io/badge/patreon-donate-orange.svg)](https://patreon.com/glenux)

<!--

> :information_source: This project is available on our self-hosted server and
> on CodeBerg and GitHub as mirrors. For the latest updates and comprehensive
> version of our project, please visit our primary repository at:
> <https://code.apps.glenux.net/glenux/gen-ai--vibe-coding--lab

-->


# GenAI Vibe Coding Lab

Welcome to the GenAI Vibe Coding Lab! This project provides a complete,
portable, and ready-to-use vibe-coding environment in a virtual machine. 

It's perfect for anyone who wants a consistent and isolated workspace packed
with the latest AI-powered coding tools, without cluttering up their main
computer.

With a single command, you can launch a Linux environment that comes
pre-installed with everything you need to start experimenting with AI in your
coding workflow.

The lab is accessible directly from your web browser via VS Code, providing a
familiar and powerful editing experience out of the box.

## Features

* **One-Command Setup**: Run `vagrant up` to build and configure your entire
  environment automatically.
* **Browser-Based IDE**: Access a full VS Code interface in your browser,
  running on the VM. It even opens this README on first launch!
* **Cross-Platform**: Works on Windows, macOS, and Linux—anywhere you can run
  Vagrant.
* **AI-Powered Tools Pre-installed**:
  * **Aider**: Chat with AI and edit code right from the terminal.
  * **Claude Code**: A command-line tool for interacting with Anthropic's
    Claude model.
  * **Cline (VS Code extension)**:  Autonomous coding agent right in your IDE,
    capable of creating/editing files, executing commands, using the browser,
    and more with your permission every step of the way.
  * **Continue (VS Code extension)**: An open-source autopilot for software
    development; a powerful extension that brings LLMs into your IDE.
  * **Crush**: The glamourous AI coding agent for your favourite terminal.
  * **Gemini CLI**: An open-source AI agent that brings the power of Gemini
    directly into your terminal. 
  * **Goose**: An open source, extensible AI agent that goes beyond code
    suggestions - install, execute, edit, and test with any LLM.
  * **Kilo Code (VS Code extension)**: An AI-powered code completion assistant
    that works inside the editor.
  * **MyCoder**:  Simple to install, powerful command-line based AI agent
    system for coding.
  * **OpenAI Codex**: Lightweight coding agent that runs in your terminal. 
* **Nested Virtualization**: Enabled by default, so you can run tools more VM
  inside the VM.

## Prerequisites

Before you begin, you must install two pieces of software on your host machine
(your main computer).

1. **A Virtualization Provider:** Vagrant uses a "provider"
   to run the virtual machine. You only need to install
   **one** of the following:
   * [**Oracle VirtualBox**](https://www.virtualbox.org/wiki/Downloads) (Free,
     recommended for beginners)
   * [**VMWare
     Workstation**](https://www.vmware.com/products/workstation-pro.html) /
     [**Fusion**](https://www.vmware.com/products/fusion.html) (Commercial)   
   * [**Libvirt / KVM**](https://libvirt.org/) (Free, best performances for Linux hosts)

2. **Vagrant:** This is the tool that reads the project
   files and automates the VM setup.
   * [**Download Vagrant**](https://developer.hashicorp.com/vagrant/downloads)

## Getting Started: A Step-by-Step Guide

### 1. Get the Project Files

You need the project files on your computer. If you have Git installed, clone
the repository. Otherwise, download the files as a ZIP and extract them to a
folder.

```bash
# Example using Git
git clone https://code.apps.glenux.net/glenux/gen-ai--vibe-coding--lab
cd gen-ai--vibe-coding--lab
```

### 2. Start the Virtual Machine

Navigate into the project directory (where the `Vagrantfile` is located) in
your terminal and run the following command:

```bash
vagrant up
```

**What's happening in the background?**

* Vagrant downloads a base Debian Linux image (this only happens once).
* It creates a new virtual machine.
* It boots the VM and runs the `provision.sh` script to install all the tools,
  including VS Code for the web, Aider, and more.

This first launch can take 5-15 minutes, depending on your internet speed.
Subsequent startups will be much faster.

### Step 3: Access Your Coding Lab

Once `vagrant up` is finished, your AI Coding Lab is running! You have two ways
to access it:

#### Option A: In Your Browser (Recommended)

This is the easiest way to get started. Open your favorite web browser and go to:

**<http://localhost:8080>**

You will see a complete VS Code interface running, ready to use. The project
folder is open, and this `README.md` file will be displayed automatically.
There is no password required.

#### Option B: In Your Terminal (Advanced)

If you prefer a traditional command-line interface, you can connect to the VM
using SSH with a simple Vagrant command:

```bash
vagrant ssh
```

You are now logged into the Debian VM. The project directory on your computer
is synchronized with the `/vagrant` directory inside the VM.

## Basic Vagrant Workflow

Here are the most common commands you'll use:

* `vagrant up`: Starts the VM and provisions it on the first run.
* `vagrant ssh`: Connects to the VM's terminal.
* `vagrant provision`: Re-runs the installation script on an already running
  VM.
* `vagrant halt`: Shuts down the VM gracefully. Run `vagrant up` again to
  restart it quickly.
* `vagrant destroy -f`: **Deletes the VM completely.** All data inside the VM
  (outside the shared `/vagrant` folder) will be lost.
* `vagrant status`: Shows the current state of the VM (e.g., running, off).

## Contributors

* Glenn ROLLAND - maintainer
* *A big thanks to all the project testers!*

## License

This project is licensed under the BSD 3-Clause License.

This is a permissive open-source license that allows you to freely use, modify,
and distribute the code, provided you retain the original copyright notice and
don't use the original contributors' names to endorse your own work without
permission.

