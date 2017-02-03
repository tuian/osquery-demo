#!/bin/bash

# set the session to be noninteractive
export DEBIAN_FRONTEND="noninteractive"



# install system tools
apt-get update
apt-get -y upgrade
apt-get install -y jq



# install the Facebook osquery repo
apt-key adv --keyserver keyserver.ubuntu.com \
    --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B 2>&1
add-apt-repository "deb [arch=amd64] https://osquery-packages.s3.amazonaws.com/xenial xenial main"
apt-get update

# install osquery
apt-get install -y osquery
osqueryd --version

# configure osquery
cp /vagrant/provision/osquery.conf \
    /etc/osquery/osquery.conf
service osqueryd start
service osqueryd status



# clean up apt-get
apt-get -y autoremove

# update file location database
updatedb
