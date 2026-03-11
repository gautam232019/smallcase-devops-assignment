#!/bin/bash

yum update -y
yum install docker -y

systemctl start docker
systemctl enable docker

docker run -d -p 8081:8081 trufiter231999/smallcase-random-app