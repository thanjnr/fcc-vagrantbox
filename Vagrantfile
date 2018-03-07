Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "provision.sh"
  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "setextradata",
      :id,
      "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root",
      "1"
    ]
  end
  config.vm.define "dev" do |dev|
      dev.vm.box = "ubuntu/xenial64"
      dev.vm.hostname = "fcc-dev"
  end
end