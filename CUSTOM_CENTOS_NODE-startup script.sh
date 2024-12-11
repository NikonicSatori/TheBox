# ========================================= #
# ~ CUSTOM NODE startup script for centos ~ #
# ========================================= #


!/bin/bash

# -- interface setup --
# Remove the existing IP address from the interface
ip addr del 172.17.0.2/16 dev eth0

# Add the new IP address to the interface
ip addr add 172.17.0.21/16 dev eth0

# Save the changes to the network configuration file to make them persistent
echo -e "auto eth0\niface eth0 inet static\n  address 172.17.0.21\n  netmask 255.255.0.0\n" | sudo tee /etc/network/interfaces.d/eth0.conf > /dev/null

# Restart the network service to apply the changes
systemctl restart networking