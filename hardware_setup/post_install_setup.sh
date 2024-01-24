#!/bin/bash
# Post install setup
# Run as root:
# su - root /home/student/post_install_setup.sh

# account name = student

# package updates
apt -y update
apt -y upgrade

# sudo enabled w/ no password
apt -y install sudo 
usermod -a -G sudo student
echo '%sudo   ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/sudo_no_password
chmod 0600 /etc/sudoers.d/sudo_no_password

# grantp account
useradd -c lecturer -G sudo -m -s /bin/bash -U grantp
mkdir -p /home/grantp/.ssh
# copy in SSH key
