#!/bin/bash
ssh -l vagrant -o StrictHostKeyChecking=no -i .vagrant/machines/gocd-demo/virtualbox/private_key 172.28.128.5 <<EOF
cd /home/vagrant/repos/main_repo
sudo sed -i -e '/package/ s/^#*/#/' /home/vagrant/repos/main_repo/src/test/java/com/tw/go/plugin/BuildStatusNotifierPluginTest.java
sudo git add -A
sudo git commit -m "Sample fail test added"
EOF
