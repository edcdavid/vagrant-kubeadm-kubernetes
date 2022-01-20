Vagrant.configure("2") do |config|
    config.vm.provision "shell", inline: <<-SHELL
        apt-get update -y
        echo "10.0.0.10  master-node" >> /etc/hosts
        echo "10.0.0.11  worker-node01" >> /etc/hosts
        echo "10.0.0.12  worker-node02" >> /etc/hosts
    SHELL
    
    config.vm.define "master" do |master|
      master.vm.hostname = "master-node"
      master.vm.network "private_network", ip: "10.0.0.10"
      master.vm.synced_folder ".", "/tmp/k8s", docker_consistency: "cached"
      master.vm.provider "docker" do |d|
          d.cmd = ["bash", "/tmp/k8s/scripts/master.sh"]
          d.build_dir = "dockerfiles/common"
          d.create_args = [ "--privileged", "--cap-add=ALL" ]
      end
    end

    (1..2).each do |i|
  
    config.vm.define "node0#{i}" do |node|
      node.vm.hostname = "worker-node0#{i}"
      node.vm.network "private_network", ip: "10.0.0.1#{i}"
      node.vm.synced_folder ".", "/tmp/k8s", docker_consistency: "cached"
      node.vm.provider "docker" do |d|
          d.cmd = ["bash", "/tmp/k8s/scripts/node.sh"]
          d.build_dir = "dockerfiles/common"
          d.create_args = [ "--privileged", "--cap-add=ALL" ]
      end
    end
    
    end
  end
