# -*- mode: ruby -*-
# vi: set ft=ruby :
@box_url="http://https://googledrive.com/host/"

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "admin" , primary: true do |admin|
#    admin.vm.box_url = "#{@box_url}/RHEL6_64-fusion503.box"
    admin.vm.box = "RHEL6_64"
    admin.vm.hostname = "admin.example.com"
    admin.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
  
    admin.vm.network :private_network, ip: "10.10.100.10"
      
    admin.vm.provider "vmware_fusion" do |v, override|
    	v.vmx["memsize"] = "1024"
    	v.vmx["numvcpus"] = "1"
    	v.vmx["name"] = "admin"
 	 end

    admin.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml"
    
    admin.vm.provision :puppet do |puppet|
      puppet.manifests_path    = "puppet/manifests"
      puppet.module_path       = "puppet/modules"
      puppet.manifest_file     = "site.pp"
      puppet.options           = "--verbose --parser future --hiera_config /vagrant/puppet/hiera.yaml"
  
      puppet.facter = {
        "environment"                     => "development",
        "vm_type"                         => "vagrant",
        "override_weblogic_user"          => "ser_dvapp",
        "override_weblogic_domain_folder" => "/opt/oracle/wlsdomains",
      }
      
    end
  
  end
  
  config.vm.define "node1" do |node1|
  	
#  	node1.vm.box_url = "#{@box_url}/RHEL6_64-fusion503.box"
    node1.vm.box = "RHEL6_64"
  
    node1.vm.hostname = "node1.example.com"
    node1.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
    node1.vm.network :private_network, ip: "10.10.100.100"
  
    
    node1.vm.provider "vmware_fusion" do |v, override|
    	v.vmx["memsize"] = "512"
    	v.vmx["numvcpus"] = "1"
    	v.vmx["name"] = "node1"
 	 end    
  
    node1.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml"
    
    node1.vm.provision :puppet do |puppet|
      puppet.manifests_path    = "puppet/manifests"
      puppet.module_path       = "puppet/modules"
      puppet.manifest_file     = "node.pp"
      puppet.options           = "--verbose --parser future --hiera_config /vagrant/puppet/hiera.yaml"
        
      puppet.facter = {
        "environment"                     => "development",
        "vm_type"                         => "vagrant",
        "override_weblogic_user"          => "ser_dvapp",
        "override_weblogic_domain_folder" => "/opt/oracle/wlsdomains",
      }
      
    end

  end

  config.vm.define "node2" do |node2|

#    node2.vm.box_url = "#{@box_url}/RHEL6_64-fusion503.box"
    node2.vm.box = "RHEL6_64"

    node2.vm.hostname = "node2.example.com"
    node2.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
    node2.vm.network :private_network, ip: "10.10.100.200", auto_correct: true
  
    node2.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1532"]
      vb.customize ["modifyvm", :id, "--name", "node2"]
    end

    node2.vm.provider "vmware_fusion" do |v, override|
    	v.vmx["memsize"] = "512"
    	v.vmx["numvcpus"] = "1"
    	v.vmx["name"] = "node2"
 	 end   
  
    node2.vm.provision :shell, :inline => "ln -sf /vagrant/puppet/hiera.yaml /etc/puppet/hiera.yaml"
    
    node2.vm.provision :puppet do |puppet|
      puppet.manifests_path    = "puppet/manifests"
      puppet.module_path       = "puppet/modules"
      puppet.manifest_file     = "node.pp"
      puppet.options           = "--verbose --parser future --hiera_config /vagrant/puppet/hiera.yaml"
  
      puppet.facter = {
        "environment"                     => "development",
        "vm_type"                         => "vagrant",
        "override_weblogic_user"          => "ser_dvapp",
        "override_weblogic_domain_folder" => "/opt/oracle/wlsdomains",
      }
      
    end

  end


end
