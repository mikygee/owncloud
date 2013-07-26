#!/bin/sh
cd bin

# Prepare Selenium
mkdir sausage && cd sausage
curl -s https://raw.github.com/jlipps/sausage-bun/master/givememysausage.php | SAUCE_USERNAME=mreinhardt SAUCE_ACCESS_KEY=28125823-d5a7-4ffe-a29b-f2976cb8d473 php
cd ..

cd ..
# SETUP OWNCLOUD
echo "Preparing owncloud setup"

sudo mkdir /var/www/mysql
sudo mkdir /var/www/mysql/4.0.8
sudo mkdir /var/www/mysql/4.0.8/apps
sudo mkdir /var/www/mysql/4.0.8/config
sudo mkdir /var/www/mysql/4.0.8/data
sudo mkdir /var/www/mysql/4.5.0
sudo mkdir /var/www/mysql/4.5.0/apps
sudo mkdir /var/www/mysql/4.5.0/config
sudo mkdir /var/www/mysql/4.5.0/data
sudo mkdir /var/www/sqllite
sudo mkdir /var/www/sqllite/4.0.8
sudo mkdir /var/www/sqllite/4.0.8/apps
sudo mkdir /var/www/sqllite/4.0.8/config
sudo mkdir /var/www/sqllite/4.0.8/data
sudo mkdir /var/www/sqllite/4.5.0
sudo mkdir /var/www/sqllite/4.5.0/apps
sudo mkdir /var/www/sqllite/4.5.0/config
sudo mkdir /var/www/sqllite/4.5.0/data

sudo cp -rp travis_ci/owncloud_releases/4.0.8 /var/www/mysql/4.0.8
sudo cp -rp travis_ci/owncloud_releases/4.0.8 /var/www/sqllite/4.0.8
sudo cp -rp travis_ci/owncloud_releases/4.5.0 /var/www/mysql/4.5.0
sudo cp -rp travis_ci/owncloud_releases/4.5.0 /var/www/sqllite/4.5.0
sudo cp -rp travis_ci/roundcube_releases/0.7.3 /var/www/roundcubemail-0.7.3
sudo cp -rp travis_ci/roundcube_releases/0.8.2 /var/www/roundcubemail-0.8.2
sudo chmod -R 777 /var/www/mysql/4.0.8/apps
sudo chmod -R 777 /var/www/mysql/4.5.0/apps
sudo chmod -R 777 /var/www/sqllite/4.0.8/apps
sudo chmod -R 777 /var/www/sqllite/4.5.0/apps
sudo chmod -R 777 /var/www/mysql/4.0.8/config
sudo chmod -R 777 /var/www/mysql/4.5.0/config
sudo chmod -R 777 /var/www/sqllite/4.0.8/config
sudo chmod -R 777 /var/www/sqllite/4.5.0/config
sudo chmod -R 777 /var/www/mysql/4.0.8/data
sudo chmod -R 777 /var/www/mysql/4.5.0/data
sudo chmod -R 777 /var/www/sqllite/4.0.8/data
sudo chmod -R 777 /var/www/sqllite/4.5.0/data
sudo chmod -R 777 /var/www/roundcubemail-0.7.3
sudo chmod -R 777 /var/www/roundcubemail-0.8.2

echo "Done with general owncloud setup"
# admin Passw0rd!
sudo cp  travis_ci/sqllite/4.0.8/config.php /var/www/sqllite/4.0.8/config/
sudo cp  travis_ci/sqllite/4.0.8/owncloud.db /var/www/sqllite/4.0.8/data/

# setup dovecot
#Create temporary file with new line in place
cat /etc/dovecot/dovecot.conf | sed -e "s/mail_location =/mail_location = mbox:~/mail:INBOX=/var/spool/mail/%u # (for mbox)/" > /tmp/dovecot.conf
#Copy the new file over the original file
mv /tmp/dovecot.conf /etc/dovecot/dovecot.conf
# setup IMAP testuser, with password imap
sudo useradd -u 601 -g users -d /home/imap1 -s /bin/bash -c IMAP 1 Testuser -p imap -m
sudo useradd -u 602 -g users -d /home/imap2 -s /bin/bash -c IMAP 2 Testuser -p imap -m

