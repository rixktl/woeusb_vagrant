# -*- mode: ruby -*-
# vi: set ft=ruby :

file_to_disk = File.realpath( "." ).to_s + '/usb.vdi'

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "2048"
    vb.cpus    = 4

    unless File.exist?(file_to_disk)
      vb.customize ['createhd',
                    '--filename', file_to_disk, 
                    '--size', 8 * 1024]
    end

    begin
      vb.customize ["storagectl", :id, "--name", "IDE Controller", "--add", "ide"]
      # vb.customize ["storagectl", :id, "--name", "SATA Controller", "--add", "sata"]
    end

    vb.customize ['storageattach', :id, 
                  '--storagectl', 'SATAController',
                  # '--storagectl', 'SATA Controller',
                  '--port', 1,
                  '--device', 0,
                  '--type', 'hdd',
                  '--medium', file_to_disk]

    vb.customize ['storageattach', :id,
                  '--storagectl', 'IDE Controller',
                  '--port', 0,
                  '--device', 0,
                  '--type', 'dvddrive',
                  '--medium', ENV['ISO_PATH']]
  end

  # Provision with Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "vagrant.yml"
  end
end
