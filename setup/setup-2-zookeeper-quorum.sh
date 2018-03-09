#!/bin/bash
# create data dictionary for zookeeper
sudo mkdir -p /data/zookeeper
sudo chown -R ubuntu:ubuntu /data/

# declare the server's identity
echo "1" > /data/zookeeper/myid

# copy zookeeper settings
rm /home/ubuntu/kafka/config/zookeeper.properties
cp zookeeper/zookeeper.properties /home/ubuntu/kafka/config/zookeeper.properties

# restart the zookeeper service
sudo service zookeeper stop
sudo service zookeeper start
