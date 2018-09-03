#!/bin/bash

sudo yum install docker
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo systemctl start docker
