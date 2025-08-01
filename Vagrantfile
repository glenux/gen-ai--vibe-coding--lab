# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

CONFIG_CPU = 2
CONFIG_MEMORY = 8096

Vagrant.configure('2') do |config|
  config.vm.box = 'debian/bookworm64'
  config.vm.box_check_update = false

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false

    ## Configure memory & CPU
    vb.memory = CONFIG_MEMORY.to_s
    # vb.cpus = CONFIG_CPU
    # vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    
    # Enable nested virtualization
    vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end

  config.vm.provider "libvirt" do |lv|
    ## Configure memory & CPU
    # lv.cpus = CONFIG_CPU.to_s
    lv.memory = CONFIG_MEMORY.to_s

    # Enable nested virtualization
    lv.nested = true
    lv.cpu_mode = "host-model"
  end

  config.vm.provider "vmware_desktop" do |vm|
    vm.gui = true

    ## Configure memory & CPU
    vm.vmx["memsize"] = CONFIG_MEMORY.to_s
    # vm.vmx["numvcpus"] = CONFIG_CPU.to_s
   
    # Enable nested virtualization
    vm.vmx['vhv.enable'] = 'TRUE'
    vm.vmx['vhv.allow'] = 'TRUE'
    vm.vmx["hypervisor.cpuid.0"] = "FALSE"
  end

  # Share folder with VM
  # config.vm.synced_folder ".", "/vagrant", type: "nfs", mount_options: ["vers=3,tcp"]
  # config.vm.synced_folder "../projects", "/vagrant/projects", type: "nfs", mount_options: ["vers=3,tcp"]

  config.vm.define 'control' do |machine|
    machine.vm.hostname = 'control'

    machine.vm.network 'forwarded_port', guest: 8080, host: 8080, host_ip: '127.0.0.1'
    machine.vm.network 'forwarded_port', guest: 80, host: 1080, host_ip: '127.0.0.1'
  end

  config.vm.provision 'shell', path: 'provision.sh'
end

