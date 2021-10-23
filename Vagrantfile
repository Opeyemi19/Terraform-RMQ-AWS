# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  common = <<-SHELL
  sudo apt update -qq 2>&1 > /dev/null
  sudo apt install ca-certificates
  echo "🌎🌍🌏🌕 Début d'installations de Terraform 🌕🌎🌍🌏"
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt install terraform
  echo "🌎🌍🌏🌕 Installation d'Ansible 🌕🌎🌍🌏"
  sudo apt install software-properties-common --yes
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible --yes
  echo "🌎🌍🌏🌕 Ajout de mon Hostname Local à Ansible 🌕🌎🌍🌏"
  echo "localhost" >> /etc/ansible/hosts && cat /etc/ansible/hosts
  echo "🌎🌍🌏🌕 Installations du package Jenkins avec playbook 🌕🌎🌍🌏"
  cd ../../vagrant/ansible/jenkins && ls && ansible-playbook provision_jenkins.yml
  echo "🌎🌍🌏🌕 Installation d'AWS CLI 🌕🌎🌍🌏"
  sudo apt-get update && sudo apt-get install awscli -y && sudo aws --version
  echo "👍Fin d'installation👍👍"
  echo "🌎🌍🌏🌕 Installations du package Jenkins avec playbook 🌕🌎🌍🌏"
  sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
  sudo systemctl restart sshd
  SHELL

    config.vm.define "jenkinserver" do |node|
      node.vm.box = "bento/ubuntu-18.04"
      node.vm.hostname = "jenkinserver"
    
      node.vm.network :private_network, type: "dhcp"
      node.vm.network "forwarded_port", guest: 22, host: "2211", id: "ssh"

      node.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", 3072]
        v.customize ["modifyvm", :id, "--name", "jenkinserver"]
      end

      node.vm.provision :shell, :inline => common

    end
end
