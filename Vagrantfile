# -*- mode: ruby -*-
# vi: set ft=ruby :

DEVSHARE=ENV['VAGRANT_SHARE_ROOT'] || "${ENV['HOME']}/vmshare"
SSHUSER=ENV['VAGRANT_SSH_USER'] || 'vagrant'
#SSHKEY=ENV['VAGRANT_SSH_KEY']

# once the chef-server.deb is installed,
#   verify it's running with `sudo chef-server-ctl status`

# https://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.6-1.ubuntu.12.04_amd64.deb

Vagrant::Config.run do |config|

  @cs_root_path      = File.dirname(File.absolute_path(__FILE__))
  @cs_box            = "UbuntuChefserverBase"
  # @cs_box_url        = (Pathname(@cs_root_path) + 'lucid64.box').to_s
  @cs_nodename       = "chef"
  @cs_tld            = "private.org"
  @cs_ip             = "10.10.10.10"   # Host-only networking
  @cs_netmask        = "255.255.255.0"
  @cs_port           = 4000
  @cs_ssh_port       = 2200
  @cs_webui_port     = 4040
  @cs_kitchen        = @cs_root_path
  @cs_validation_client_name = "chef-validator"

  config.vm.define :chef do |conf|

    conf.vm.host_name = "chefserver.vm"
    conf.vm.box = "UbuntuChefserverBase"
    # conf.vm.box_url = "#{@cs_box_url}"
    conf.vm.customize ["modifyvm", :id, "--memory", "1024"]

    #conf.vm.forward_port "web", 80, 8080 # necessary?
    conf.vm.forward_port @cs_port, @cs_port
    conf.vm.forward_port @cs_webui_port, @cs_webui_port
    #conf.vm.forward_port 443, @cs_webui_host_ssl
    conf.vm.forward_port 22, @cs_ssh_port, auto: true

    conf.vm.boot_mode = :headless # or :gui

    # networking
    #   hostonly to communicate with other VM's
    #   not accessible to outsite network
    #   doesn't need to be on the host machine's net .. i think?
    conf.vm.network :hostonly, @cs_ip, netmask: @cs_netmask
    conf.ssh.username = SSHUSER
    conf.ssh.shell = "/usr/bin/zsh"

    # NFS shared-folder
    #   host - `which nfsd`; brew install?
    #   guest - sudo apt-get install nfs-kernel-server nfs-common
    conf.vm.share_folder("devshare", '/vagrant', DEVSHARE, :nfs => true)

    # chef-solo shares, which contain the cookbooks to config chef
    #   but, at this point, all the services are up and running in ubuntu box
    #   and this would require chef-solo installation on macbook
    #conf.vm.share_folder("chef", "~/chef", "#{@cs_root_path}/mnt/chef")
    #conf.vm.share_folder("chef-server-etc", "/etc/chef", "#{@cs_kitchen}/mnt/etc" )
    #conf.vm.share_folder("chef-cookbooks-0", "/tmp/vagrant-chef/cookbooks-0", "#{@cs_kitchen}/site-cookbooks")
    #conf.vm.share_folder("chef-cookbooks-1", "/tmp/vagrant-chef/cookbooks-1", "#{@cs_kitchen}/cookbooks")

    # provisions can be called multiple times
    #conf.vm.provision

    # configure vagrant to use host's chef-solo (?)
    #   to configure chef-server on the guest os
    # conf.vm.provision :chef_solo do |chef|
    #   chef.log_level = :debug # :info or :debug
    #   chef.node_name = @cs_nodename
    #   chef.cookbooks_path = [
    #                          File.expand_path("#{@cs_kitchen}/site-cookbooks"),
    #                          File.expand_path("#{@cs_kitchen}/cookbooks")]
    #   chef.add_recipe("hosts::chefserver")
    #   chef.add_recipe("apt")
    #   chef.add_recipe("build-essential")
    #   chef.add_recipe("chef-server::rubygems-install")
    #   chef.json.merge!({
    #                      :chef_server=> {
    #                        :name=> @cs_nodename,
    #                        :validation_client_name=> @cs_validation_client_name,
    #                        :url_type=>"http",
    #                        :server_fqdn=> "#{@cs_nodename}.#{@cs_tld}",
    #                        :server_port=> "#{@cs_port}",
    #                        :webui_port=> "#{@cs_webui_port}",
    #                        :webui_enabled=> true,
    #                        :umask => '0644'
    #                      }
    #                    })
    # end

    # example of more vbox customization options
    # conf.customize do |cvm|
    #   cvm.memory_size = 1024
    #   cvm.vram_size = 12
    #   cvm.cpu_count = 2
    #   cvm.accelerate_3d_enabled = false
    #   cvm.accelerate_2d_video_enabled = false
    #   cvm.monitor_count = 1

    #   cvm.bios.acpi_enabled = true
    #   cvm.bios.io_apic_enabled = false

    #   cvm.cpu.pae = true

    #   cvm.hw_virt.enabled = false
    #   cvm.hw_virt.nested_paging = false
    #   # STORAGE
    # end

  end

end

# provisioning vagrant boxes with chef
# http://docs.vagrantup.com/v1/docs/provisioners/chef_server.html

# manage dns for vagrant hosts/guests
# https://github.com/mosaicxm/vagrant-hostmaster

# vagrantfile example in Cuken gem specs
# https://github.com/hedgehog/cuken/blob/master/features/chef_examples/zenoss_example/01_chef_server_setup.feature

# server-bootstrap. hmmm...
# https://github.com/masterexploder/server-bootstrap

# chef hatch repo
# https://github.com/xdissent/chef-hatch-repo

#===============================
# HOW TO LOAD DOTFILES
#===============================
# example of loading dotfiles onto vm
# http://www.without-brains.net/blog/2012/08/12/add-your-own-customization-to-vagrant-boxes/
#Vagrant::Config.run do |config|
#  config.vm.share_folder "v-dotfiles", "/home/vagrant/.dotfiles", File.expand_path("~/.dotfiles")
#  config.vm.provision :shell, :path => File.join(File.dirname(__FILE__), "scripts", "provision")
#end

#!/usr/bin/env bash
#  DOTFILES SETUP SCRIPT:
#export DEBIAN_FRONTEND=noninteractive
#apt-get update > /dev/null
#apt-get -y install tmux vim zsh git-core
#su -c "cd /home/vagrant/.dotfiles && ./setup" vagrant

#===============================
# ORIGINAL VAGRANTFILE CONFIG
#===============================
#Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "base"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "192.168.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "base.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
#end
