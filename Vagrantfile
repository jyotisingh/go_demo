# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.define "gocd-demo" do |vm_config|
        vm_config.vm.network "private_network", type: "dhcp"
        vm_config.vm.network "forwarded_port", guest: 8153, host: 8153
        vm_config.vm.network "forwarded_port", guest: 8154, host: 8154
        vm_config.vm.provision "shell", inline: "apt-get update"
        vm_config.vm.provision "shell", inline: "apt-get install -y software-properties-common python-software-properties"
        vm_config.vm.provision "shell", inline: "add-apt-repository ppa:openjdk-r/ppa"
        vm_config.vm.provision "shell", inline: "echo 'deb https://download.gocd.io /' | sudo tee /etc/apt/sources.list.d/gocd.list"    
        vm_config.vm.provision "shell", inline: "curl https://download.gocd.io/GOCD-GPG-KEY.asc | sudo apt-key add -"    
        vm_config.vm.provision "shell", inline: "apt-get install -y apt-transport-https ca-certificates"    
        vm_config.vm.provision "shell", inline: "curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -"    
        vm_config.vm.provision "shell", inline: "add-apt-repository 'deb https://apt.dockerproject.org/repo/ ubuntu-trusty main'"    
        vm_config.vm.provision "shell", inline: "apt-get update"
        vm_config.vm.provision "shell", inline: "apt-get install -y rake openjdk-8-jdk unzip git wget maven2 docker-engine go-server go-agent"
        vm_config.vm.provision "shell", inline: "update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-openjdk-amd64/bin/java 1"
        vm_config.vm.provision "shell", inline: "update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/bin/java"
        vm_config.vm.provision "shell", inline: "/etc/init.d/go-server stop"    
        vm_config.vm.provision "shell", inline: "tar -xvf /vagrant/repos.tar.gz"    
        vm_config.vm.provision "shell", inline: "chown -R vagrant:vagrant /home/vagrant/repos"    
        vm_config.vm.provision "shell", inline: "git config --global user.email go_demo@gmail.com"    
        vm_config.vm.provision "shell", inline: "git config --global user.name Go_Demo"    
        vm_config.vm.provision "shell", inline: "/usr/bin/git daemon --base-path=/home/vagrant/repos --export-all --enable=receive-pack --reuseaddr --informative-errors --verbose --detach"    
        vm_config.vm.provision "shell", inline: "cp /vagrant/config/* /etc/go/"
        vm_config.vm.provision "shell", inline: "wget https://github.com/gocd-contrib/docker-elastic-agents/releases/download/v0.6.1/docker-elastic-agents-0.6.1.jar -O /var/lib/go-server/plugins/external/docker-elastic-agents-0.6.1.jar"
        vm_config.vm.provision "shell", inline: "chown -R go:go /etc/go/"
        vm_config.vm.provision "shell", inline: "chown -R go:go /var/go/"
        vm_config.vm.provision "shell", inline: "chown -R go:go /var/lib/go-server/"
        vm_config.vm.provision "shell", inline: "cp /etc/init.d/go-agent /etc/init.d/go-agent-1"
        vm_config.vm.provision "shell", inline: "sed -i 's/# Provides: go-agent$/# Provides: go-agent-1/g' /etc/init.d/go-agent-1"
        vm_config.vm.provision "shell", inline: "ln -Ffs /usr/share/go-agent /usr/share/go-agent-1"
        vm_config.vm.provision "shell", inline: "cp -p /etc/default/go-agent /etc/default/go-agent-1"
        vm_config.vm.provision "shell", inline: "mkdir -p /var/{lib,log}/go-agent-1"
        vm_config.vm.provision "shell", inline: "chown go:go /var/{lib,log}/go-agent-1"
        vm_config.vm.provision "shell", inline: "update-rc.d go-agent-1 defaults"
        vm_config.vm.provision "shell", inline: "/etc/init.d/go-server start"   
        vm_config.vm.provision "shell", inline: "/etc/init.d/go-agent start"     
        vm_config.vm.provision "shell", inline: "/etc/init.d/go-agent-1 start"


      vm_config.vm.provider :virtualbox do |vb, override|
        override.vm.box = 'boxcutter/ubuntu1404'
        vb.gui    = false
        vb.memory = ((ENV['MEMORY'] || 4).to_f * 1024).to_i
        vb.cpus   = 4
        vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
      end
    end

   if Vagrant.has_plugin?('vagrant-cachier')
     config.cache.scope = :box
     config.cache.enable :apt
     config.cache.enable :apt_lists
     config.cache.enable :yum
   end
end
