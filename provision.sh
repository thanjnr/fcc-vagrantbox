#!/bin/bash

apt-get -y update

#install nodejs & npm
dpkg -s npm &>/dev/null || {
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    apt-get -y install nodejs build-essential
}

#install mongodb
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
apt-get -y update
sudo apt-get install -y mongodb-org
systemctl enable mongod.service

#install mailhog
echo ">>> Installing Mailhog"
wget --quiet -O ~/mailhog https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64
# Make it executable
chmod +x ~/mailhog

#clone freeCodeCamp repository
sudo -u vagrant -i sh -c 'cd /vagrant;git clone https://github.com/thanjnr/freeCodeCamp.git'   
sudo -u vagrant -i sh -c 'cd /vagrant/freeCodeCamp;git remote add upstream https://github.com/freeCodeCamp/freeCodeCamp.git;git checkout staging'   
sudo -u vagrant -i sh -c 'cd /vagrant/freeCodeCamp; npm install'
sudo -u vagrant -i sh -c 'cp /vagrant/freeCodeCamp/sample.env /vagrant/freeCodeCamp/.env'
cp /vagrant/upstart/mailhog.conf /etc/init/mailhog.conf
sudo -u vagrant -i sh -c 'cd /vagrant/freeCodeCamp; npm run only-once'