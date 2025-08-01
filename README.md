
# README

This project provides a fully configured, portable, and reproducible development environment using Vagrant. It sets up a Debian "Bookworm" virtual machine packed with modern, AI-powered coding tools, perfect for developers who want an isolated and consistent workspace.

The environment is designed to be ready-to-use out of the box, with nested virtualization enabled, making it suitable for running containerized applications (like Docker) or even other virtual machines inside it.

## Features

* **Automated Setup**: A single command (`vagrant up`) builds your entire development environment.
* **Cross-Platform**: Works on any system that can run Vagrant (Windows, macOS, Linux).
* **Multi-Provider Support**: Configuration is provided for VirtualBox, VMWare, and Libvirt (KVM).
* **Nested Virtualization**: Enabled by default, allowing you to run Docker, Minikube, etc., inside the VM.
* **AI-Powered Tooling**: Comes pre-installed with a suite of AI coding assistants:
  * **Aider**: AI pair programming directly in your terminal.
  * **Claude Code**: Command-line tool from Anthropic.
  * **Crush**: A smart shell command generator.
* **Modern Development Utilities**:
  * **asdf**: A universal version manager for runtimes like Node.js, Python, Ruby, etc.
  * **direnv**: Manages per-project environment variables.
  * **Goose**: A database migration tool.
* **Pre-configured Port Forwarding**: Access web applications running inside the VM directly from your local machine.

## Prerequisites

Before you begin, you must install two pieces of software on your host machine (your main computer).

1. **A Virtualization Provider:** Vagrant uses a "provider" to run the virtual machine. You only need to install **one** of the following:
   * [**Oracle VirtualBox**](https://www.virtualbox.org/wiki/Downloads) (Free, recommended for beginners)
   * [**VMWare Workstation**](https://www.vmware.com/products/workstation-pro.html) / [**Fusion**](https://www.vmware.com/products/fusion.html) (Commercial, requires a paid Vagrant plugin)
   * [**Libvirt / KVM**](https://libvirt.org/) (For Linux hosts)

2. **Vagrant:** This is the tool that reads the project files and automates the VM setup.
   * [**Download Vagrant**](https://developer.hashicorp.com/vagrant/downloads)

## Getting Started: A Step-by-Step Guide

### 1. Get the Project Files

First, you need to have the project files on your computer. If this project is in a Git repository, you can clone it. Otherwise, simply download and extract the files to a folder.

```bash
# Example if using Git
git clone https://example.com/your/repository.git
cd repository
```

### 2. Start the Virtual Machine

Navigate into the project directory (where the `Vagrantfile` is located) in your terminal and run the following command:

```bash
vagrant up
```

**What is happening?**
* Vagrant will download the `debian/bookworm64` base image (if you don't have it already).
* It will create a new virtual machine based on the settings in `Vagrantfile`.
* It will boot the VM and run the `provision.sh` script to install all the tools.

This process can take 5-15 minutes on the first run, depending on your internet connection and computer speed. You will see a lot of output in your terminal as software is downloaded and installed.

### 3. Connect to the VM via SSH

Once `vagrant up` completes successfully, the VM is running in the background. You can connect to its command line using SSH with this simple command:

```bash
vagrant ssh
```

You are now inside the Debian VM! The user is `vagrant`, and the current directory (`/vagrant`) is synchronized with your project folder on your host machine. Any changes you make here will be reflected on your host, and vice-versa.

### 4. Accessing Web Services

The `Vagrantfile` is configured to forward network ports from the VM (the "guest") to your computer (the "host"). This allows you to access web applications running inside the VM using your local web browser.

* **Guest Port `8080`** -> **Host Port `8080`**
* **Guest Port `80`** -> **Host Port `1080`**

## Basic Vagrant Workflow

Here are the most common commands you will use:

* `vagrant up`: Starts and provisions the VM.
* `vagrant ssh`: Connects to the VM.
* `vagrant provision`: Re-runs the installation script (`provision.sh`) on an already running VM.
* `vagrant halt`: Shuts down the VM gracefully (fast to restart).
* `vagrant destroy`: **Deletes the VM completely.** All changes made inside the VM (outside the `/vagrant` shared folder) will be lost. Use `vagrant destroy -f` to skip the confirmation prompt.
* `vagrant status`: Shows the current state of the VM (running, saved, off, etc.).

## Contributors

* Glenn ROLLAND

## License

BSD-3

