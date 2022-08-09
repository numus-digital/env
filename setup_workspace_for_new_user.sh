#!/bin/bash

echo "seting up aws sso.  login in browser when prompted..."
mkdir ~/.aws
cat awsconfig > ~/.aws/config
/usr/local/bin/aws configure sso --profile numeus-wks

echo "generating ssh keys..."
ssh-keygen -f $HOME/.ssh/id_rsa -P '' -q
echo -e "\e[32mpaste the following into you github settings->ssh and gpg keys->new ssh key:\e[0m"
cat ~/.ssh/id_rsa.pub
echo
read -p 'Press enter to continue...'

echo "cloning nte..."
cd
git clone git@github.com:numus-digital/nte.git

echo "setting fancy fonts..."
dconf write "/org/mate/desktop/interface/monospace-font-name" "'SauceCodePro Nerd Font Mono 10'"

rm -rf ~/env

echo "adding user to docker group..."
sudo usermod -aG docker $USER
newgrp docker

