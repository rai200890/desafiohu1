#!/usr/bin/env bash
#MySQL Installation
export MYSQL_ROOT_USERNAME=root
export MYSQL_ROOT_PASSWORD=root
sudo apt-get -y install debconf-utils
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password '$MYSQL_ROOT_PASSWORD
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password '$MYSQL_ROOT_PASSWORD
sudo apt-get -y install mysql-server
sudo apt-get -y install  libmysqlclient-dev