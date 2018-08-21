# -*- mode: ruby -*-
# vi: set ft=ruby :

# To fix certain basic parameters of your virutal machines, edit the
# config.yaml file in the same directory. The available parameters are:
# - name
#     Your virtual machine's name. Used with various vagrant commands including
#     vagrant up NAME and vagrant ssh NAME.
# - vagrant box
#     To change this, also ensure that the appropriate vagrant box file is
#     located in the appropriate directory. For Linux as OS X, this directory
#     is ~/.vagrant.d/boxes,for windows it is C:/Users/USERNAME/.vagrant.d/boxes
# - cpus
#     The number of cores your virtual machine is assigned
# - memory
#     The maximum amount of RAM your virtual machine can access
# - private_ip
#     The address by which you can access your virtual machine from the host
# - scripts
#     A list of scripts to install on startup. For each script listed you must
#     place a corresponding script file in the vagrant_scripts folder
# - portfrom/portto
#     Allows port forwarding from "portfrom" of the guest machine to "portto" on
#     the host machine. Only one pair of ports may be defined currently.
# - sharedfolder
#     Path (relative or absolute) to a directory on the host machine that will
#     be accessible on the virtual machine. Currently uses nfs, which requires
#     root privileges. The corresponding folder in the guest system is found
#     in the /home/ directory.
require 'yaml'
require 'json'
#if File.exist?("config.yml")
#  machines = YAML.load_file("config.yml")
#else
if File.exist?("config.json")
  configfile = File.read("config.json")
  machines = JSON.parse(configfile)
end
#end


Vagrant.configure("2") do |config|
  machines.each do |machine|
    config.vm.define machine['name'] do |machine_vm|
      set_box(machine, machine_vm)
      hardware_setup(machine, machine_vm)
      ip_setup(machine, machine_vm)
      script_handler(machine, machine_vm)
      setup_port(machine, machine_vm)
      setup_shared_folder(machine, machine_vm)
    end
  end
end

def set_box(machine, machine_vm)
   machine_vm.vm.box = machine['box']
end

def hardware_setup(machine, machine_vm)  
  machine_vm.vm.provider "virtualbox" do |vb|
    vb.cpus = machine['cpus']
    vb.memory = machine['memory']
  end
end

def ip_setup(machine, machine_vm)
  machine_vm.vm.network "private_network", ip: machine['private_ip']
end

def script_handler(machine, machine_vm)  
  unless machine['scripts'].nil?
    machine['scripts'].each do |script|
      machine_vm.vm.provision "shell", privileged: false, path: "vagrant_scripts/#{script}"
    end
  end
end

def setup_port(machine, machine_vm)
  unless machine['portto'].nil?
    machine_vm.vm.network "forwarded_port", guest: machine['portfrom'], host: machine['portto']
  end
end

def setup_shared_folder(machine, machine_vm)
  unless machine['sharedfolder'].nil?
    machine_vm.vm.synced_folder machine['sharedfolder'], '/home/hostshare', nfs: true
  end
end


#def update_with_package_manager(machine, machine_vm)
#  unless machine['package_manager'].nil?
#    machine_vm.vm.provision "shell", inline: "sudo #{machine['package_manager']#} update -y"
#    if machine['package_manager'] == "apt"
#      machine_vm.vm.provision "shell", inline: "sudo #{machine['package_manager#']} upgrade -y"
#    end
#  end
#end
#
#def install_packages(machine, machine_vm)
#  unless machine['packages'].nil?
#    if machine['package_manager'] == "apk"
#      machine_vm.vm.provision "shell", inline: <<-SHELL
 #       sudo #{machine['package_manager']} add #{machine['packages  '].join(" ")}
#	                        		SHELL
#    else
#      machine_vm.vm.provision "shell", inline: <<-SHELL
#        sudo #{machine['package_manager']} install -y #{machine['packages'].joi#n(" ")}#
#			SHELL
#    end
#  end
#end
