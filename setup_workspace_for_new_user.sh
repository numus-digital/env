#!/bin/bash

echo "seting up aws sso.  login in browser when prompted..."
mkdir ~/.aws
cat awsconfig > ~/.aws/config
#/usr/local/bin/aws configure sso --profile numeus-wks

cat gitconfig > ~/.gitconfig
NAME=`whoami | sed "s/\..*//"`
echo "name = $NAME" >> ~/.gitconfig
echo "email = $NAME@numeus.xyz" >> ~/.gitconfig

echo "generating ssh keys..."
ssh-keygen -f $HOME/.ssh/id_rsa -P '' -q
ssh-copy-id localhost
echo -e "\e[32mpaste the following into you github settings->ssh and gpg keys->new ssh key:\e[0m"
cat ~/.ssh/id_rsa.pub
echo
read -p 'Press enter to continue...'

echo "cloning nte..."
mkdir -p ~/src
cd ~/src
git clone git@github.com:numus-digital/nte.git

echo "setting docker dns..."
cat <<EOT >> /etc/docker/daemon.json
{
    "dns": ["10.250.9.168", "8.8.8.8"]
}
EOT

echo "setting fancy fonts..."
dconf write "/org/mate/desktop/interface/monospace-font-name" "'SauceCodePro Nerd Font Mono 10'"

rm -rf ~/env

echo "adding user to docker group..."
sudo usermod -aG docker $USER
newgrp docker
