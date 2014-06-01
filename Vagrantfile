Vagrant.configure('2') do |config|
  config.vm.define 'default' do |machine|
    machine.vm.box = 'phusion/ubuntu-14.04-amd64'

    machine.vm.network :private_network, ip: "192.168.33.10"
    machine.vm.network :forwarded_port, guest: 3000, host: 3010
    machine.vm.network :forwarded_port, guest: 6379, host: 6379
    machine.vm.network :forwarded_port, guest: 5432, host: 5432

    machine.vm.provider :virtualbox do |v|
      v.memory = 4096
      v.cpus = 8
    end

    machine.vm.provision :docker do |docker|
      docker.pull_images 'busybox'
      docker.pull_images 'ubuntu'
      docker.pull_images 'nornagon/postgres'
      docker.pull_images 'goodguide/base-ruby-2.1.1'
    end
  end

  # config.vm.define 'postgres' do |machine|
  #   machine.vm.provider "docker" do |docker|
  #     docker.image = "nornagon/postgres"
  #     docker.name = 'postgres'
  #     docker.volumes = [
  #       "/etc/postgresql",
  #       "/var/log/postgresql",
  #       "/var/lib/postgresql"
  #     ]
  #     docker.ports = [
  #       '5432:5432'
  #     ]
  #     docker.remains_running = true
  #     docker.vagrant_vagrantfile = File.expand_path('../Vagrantfile.docker_host', __FILE__)
  #   end
  # end

  # config.vm.define 'redis' do |machine|
  #   machine.vm.provider 'docker' do |docker|
  #     docker.image = 'dockerfile/redis'
  #     docker.name = 'redis'
  #     docker.ports = [
  #       '6379:6379'
  #     ]
  #     docker.remains_running = true
  #     docker.vagrant_vagrantfile = File.expand_path('../Vagrantfile.docker_host', __FILE__)
  #   end
  # end

  # config.vm.define 'web' do |machine|
  #   machine.vm.provider 'docker' do |docker|
  #     docker.image = 'goodguide/base-ruby-2.1.1'
  #     docker.ports = [
  #       '3000:3000'
  #     ]
  #     docker.link 'postgres:db'
  #     docker.link 'redis'
  #     docker.vagrant_vagrantfile = File.expand_path('../Vagrantfile.docker_host', __FILE__)
  #   end
  # end
end
