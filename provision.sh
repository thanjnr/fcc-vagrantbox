#!/bin/bash

apt-get -y update

#install nodejs & npm
dpkg -s npm &>/dev/null || {
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    apt-get -y install nodejs build-essential
}

#install mailhog
echo ">>> Installing Mailhog"
wget --quiet -O ~/mailhog https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64
# Make it executable
chmod +x ~/mailhog

cp /vagrant/upstart/mailhog.conf /etc/init/mailhog.conf

#clone freeCodeCamp repository
sudo -u vagrant -i sh -c `    
    cd /vagrant;
    git clone https://github.com/thanjnr/freeCodeCamp.git;
    cd /vagrant/freeCodeCamp;
    git remote add upstream https://github.com/freeCodeCamp/freeCodeCamp.git;
    git checkout staging;
    npm install --no-bin-links;
`