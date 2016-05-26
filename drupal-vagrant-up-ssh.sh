#!/bin/bash
if [ -f $1 ]
then
  echo 'Please enter a vagrant box to start, either drupal7 or laravel'
  exit
fi
echo "go to drupal vagrant directory"
cd ~/Vagrant/vagrant-ansible-$1/
echo "check to see if vagrant already up"
if vagrant status | grep -q poweroff;
then
  echo "vagrant up";
  vagrant up;
fi
vagrant ssh
