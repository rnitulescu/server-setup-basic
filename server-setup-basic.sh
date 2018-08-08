#! /bin/sh

## Script to run to get a fresh server secured and usable
## (only tested with digital ocean droplets running Ubuntu 16.04)

## 1) SSH into the server (and change root password immediately)
# ssh root@my_server_ip

## 2) Create you own user account
# adduser myname

## 3) Give this user administrative privileges (i.e., add to sudoers)
# usermod -aG sudo myname

## 4) Copy your local SSH public key (id_rsa.pub) to the 'authorized_keys' file on the server
##    Careful about the file permissions here
##    First, switch users, then create the ssh directory, etc.
# su - myname
# mkdir ~/.ssh
# chmod 700 ~/.ssh
##    manually copy the key to the file 'authorized_keys'
# chmod 600 ~/.ssh/authorized_keys
##    Switch back to root
# exit

## 5) Disable SSH password-only authentication (to avoid people logging in without an authorized key)
# sudo vim /etc/ssh/sshd_config
##    At the line that says "PasswordAuthentication", uncomment and replace 'yes' with 'no'
##    Make sure the following options are also set:
##    PubkeyAuthenticaton yes
##    ChallengeResponseAuthentication no
##    And reload sshd, without dropping current connectons:
# sudo systemctl reload sshd

## 6) Test new user account (in a new terminal)
# ssh myname@my_server_ip
##    If it connects successfully, then you can log off the root account

## 7) Disable root login
#     Go back to sshd_config file and set "PermitRootLogin" option to 'no'
#     and reload sshd again, as above

## 8) Set up basic firewall (just allow SSH for now?)
# TODO



