# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# Configuration
#
# Feel free to adjust these values based on your host machine's resources.
# 8GB of RAM is recommended for running AI tools smoothly.
#
CONFIG_CPU = 2
CONFIG_MEMORY = 8096

Vagrant.configure('2') do |config|
  ##
  ## Global configuration
  ##
  config.vm.box = 'debian/bookworm64'
  config.vm.box_check_update = false

  # Optional: share folders with virtual machines
  #
  #   config.vm.synced_folder ".",
  #     "/vagrant",
  #     type: "nfs",
  #     mount_options: ["vers=3,tcp"]
  #   config.vm.synced_folder "../projects",
  #     "/vagrant/projects",
  #     type: "nfs",
  #     mount_options: ["vers=3,tcp"]

  ##
  ## Provider-Specific Configuration
  ##

  # Configuration for VirtualBox (default)
  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.memory = CONFIG_MEMORY.to_s
    vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]

    # Optional: configure the number of CPUs & CPU execution cap
    #
    #   vb.cpus = CONFIG_CPU
    #   vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

  # Configuration for Libvirt (KVM) on Linux hosts
  config.vm.provider "libvirt" do |lv|
    lv.memory = CONFIG_MEMORY.to_s
    lv.nested = true
    lv.cpu_mode = "host-model"

    # Optional: configure the number of CPUs & CPU execution cap
    #
    #   lv.cpus = CONFIG_CPU.to_s
  end

  # Configuration for VMWare Desktop (Workstation/Fusion)
  config.vm.provider "vmware_desktop" do |vm|
    vm.gui = false
    vm.vmx["memsize"] = CONFIG_MEMORY.to_s
    vm.vmx['vhv.enable'] = 'TRUE'
    vm.vmx['vhv.allow'] = 'TRUE'
    vm.vmx["hypervisor.cpuid.0"] = "FALSE"

    # Optional: configure the number of CPUs & CPU execution cap
    #
    #   vm.vmx["numvcpus"] = CONFIG_CPU.to_s
  end


  config.vm.define 'genai-lab' do |machine|
    machine.vm.hostname = 'genai-lab'

    ## Port Forwarding
    # This maps ports from the VM (guest) to your computer (host).
    machine.vm.network 'forwarded_port',
      guest: 8080,
      host: 8080,
      host_ip: '127.0.0.1'

    machine.vm.network 'forwarded_port',
      guest: 80,
      host: 1080,
      host_ip: '127.0.0.1'

    # Run the provisioning script to install all the software.
    machine.vm.provision 'shell', path: 'provision.sh'
  end
end

