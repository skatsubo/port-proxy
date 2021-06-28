#!/bin/sh

# see https://www.everythingcli.org/ssh-tunnelling-for-fun-and-profit-autossh/

apt-get update
apt-get install -y autossh

echo '[Unit]
Description=AutoSSH tunnel
After=network.target
[Service]
Environment="AUTOSSH_GATETIME=0"
ExecStart=/usr/bin/autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -N -p24 user@bastionhost.com -L 127.0.0.1:13306:dbhost:3306
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/autossh.service

systemctl daemon-reload ; systemctl enable autossh ; systemctl start autossh 
