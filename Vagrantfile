Vagrant.configure('2') do |config|
  config.vm.define 'postgres' do |machine|

    machine.vm.provider "docker" do |docker|
      docker.image = "nornagon/postgres"
      docker.name = 'postgres'
      docker.volumes = [
        "/etc/postgresql",
        "/var/log/postgresql",
        "/var/lib/postgresql"
      ]
      docker.ports = [
        '5432:5432'
      ]
      docker.remains_running = true
      docker.vagrant_vagrantfile = File.expand_path('../Vagrantfile.docker_host', __FILE__)
    end
  end

  config.vm.define 'redis' do |machine|
    machine.vm.provider 'docker' do |docker|
      docker.image = 'dockerfile/redis'
      docker.name = 'redis'
      docker.ports = [
        '6379:6379'
      ]
      docker.remains_running = true
      docker.vagrant_vagrantfile = File.expand_path('../Vagrantfile.docker_host', __FILE__)
    end
  end

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
