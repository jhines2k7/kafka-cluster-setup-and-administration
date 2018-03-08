#!/bin/bash
# Packages
sudo apt-get update && sudo apt-get -y install wget ca-certificates zip net-tools vim nano tar netcat

# Java Open JDK 8
sudo apt-get -y install default-jdk && java -version

# Disable RAM Swap - can set to 0 on certain Linux distro
sudo sysctl vm.swappiness=1
echo 'vm.swappiness=1' | sudo tee --append /etc/sysctl.conf

# Add hosts entries (mocking DNS) - put relevant IPs here
echo "10.0.0.77 kafka1
10.0.0.77 zookeeper1
10.0.0.230 kafka2
10.0.0.230 zookeeper2
10.0.0.28 kafka3
10.0.0.28 zookeeper3" | sudo tee --append /etc/hosts

# download Zookeeper and Kafka. Recommended is latest Kafka (0.10.2.1) and Scala 2.12
cd /home/ubuntu
wget http://apache.mirror.digitalpacific.com.au/kafka/0.10.2.1/kafka_2.12-0.10.2.1.tgz
tar -xvzf kafka_2.12-0.10.2.1.tgz
rm kafka_2.12-0.10.2.1.tgz
mv kafka_2.12-0.10.2.1 kafka

# Install Zookeeper boot scripts
# sudo nano /etc/init.d/zookeeper
cd /home/ubuntu/kafka-cluster-setup-and-administration
sudo cp zookeeper/zookeeper /etc/init.d 
sudo chmod +x /etc/init.d/zookeeper
sudo chown root:root /etc/init.d/zookeeper
# you can safely ignore the warning
sudo update-rc.d zookeeper defaults
# stop zookeeper
sudo service zookeeper stop
# verify it's stopped
nc -vz localhost 2181
# start zookeeper
sudo service zookeeper start
# verify it's started
nc -vz localhost 2181
# check the logs
cd /home/ubuntu/kafka
cat logs/zookeeper.out
