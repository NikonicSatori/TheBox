# ======================== #
# ~ startup shell script ~ #
# ======================== #

!/bin/bash

# ======================
# -- Install packages --
# ======================
dnf update -y
dnf makeceache # need to move after epel-release?

# ------------------
# - Core Utilities -
# ------------------
#dnf install -y coreutils
 # Basic file, shell, and text manipulation utilities (e.g., ls, cat, rm).
dnf install -y findutils
 # Utilities for searching files (find, xargs, etc.).
dnf install -y bash-completion
 # Command auto-completion for the Bash shell.


# ---------------------
# - Network Utilities -
# ---------------------
dnf install -y iputils
 # Includes ping, traceroute, and other network utilities.
dnf install -y bind-utils
 # DNS lookup tools (dig, nslookup, host).
#dnf install -y net-tools
 # Legacy network tools (ifconfig, netstat, etc.).
dnf install -y iproute
 # Modern networking tools (ip route, ip address).
#dnf install -y traceroute
 # Traces network routes.
#dnf install -y nmap
 # Network reconnaissance: Network scanning and security auditing.
#dnf install -y tcpdump
 # Network monitoring: Network packet capture tool.
#dnf install -y ethtool
 # Network interface configuration. 
dnf install -y wget
dnf install -y curl
 # HTTP and FTP clients

# ---------------------------------
# - Disk and Filesystem Utilities -
# ---------------------------------
dnf install -y util-linux
 # Includes basic system utilities (more, mount, kill, etc.).
#dnf install -y lsof
 # Lists open files.
#dnf install -y parted
 # Disk partitioning utility.
#dnf install -y
 # Tools for managing XFS filesystems.
#dnf install -y
 # Tools for managing ext2/ext3/ext4 filesystems.
#dnf install -y
 # Converts between DOS and UNIX text file formats.

# -------------------------------------
# - System Monitoring and Performance -
# -------------------------------------
dnf install -y procps-ng
 # Process monitoring and management (e.g., ps, top, kill).
#dnf install -y htop
 # Interactive process viewer. *Included in procps-ng
#dnf install -y iotop
 # I/O usage monitoring by processes.
#dnf install -y sysstat 
 # Performance monitoring utilities (e.g., sar, iostat).
#dnf install -y dmidecode
 # Displays hardware information.
#dnf install -y strace
 # Traces system calls.

# ---------------------------------------
# - Package Management and Repositories -
# ---------------------------------------
dnf install -y epel-release
 # Adds the EPEL repository for extra packages.
#dnf install -y dnf-utils
 # Adds utilities like yum-config-manager.
#dnf install -y rpm-build
 # Tools for building RPM packages.

# ---------------------
# - Development Tools -
# ---------------------
dnf install -y git
 # Version control.
dnf install -y python3-pip
 # Python
#dnf install -y make
 # Build automation tool.
#dnf install -y cmake
 # Cross-platform build system.

# ---------------------
# - Security Tools -
# ---------------------
dnf install -y firewalld
 # Firewall management tool.
dnf install -y openssl
 # OpenSSL tools for managing certificates and keys.
#dnf install -y fail2ban
 # Prevents brute-force attacks.
#dnf install -y audit
 # Auditing tools for security.

# -----------------------------
# - Archiving and Compression -
# -----------------------------
dnf install -y zip
 # For handling .zip files.
dnf install -y tar
 # Archiving utility.
#dnf install -y gzip
 # Compression utility.
#dnf install -y bzip2
 # Better compression than gzip.
#dnf install -y xz
 # High compression utility.
#dnf install -y rsync
 # File synchronization and transfer.

# -----------------------------
# - Miscellaneous Utilities -
# -----------------------------
dnf install -y man-db
 # Manual pages (man command).
dnf install -y passwd
 # Changes user passwords
dnf install -y screen
 # Terminal multiplexers.
dnf install -y tree
 # Displays directory trees.
dnf install -y nano
 # Lightweight text editor.

# -----------
# - Cleanup -
# -----------
dnf clean all
dnf update -y


# ========================
# -- Add user and login --
# ========================
useradd buddha
echo "132123" | passwd --stdin buddha
usermod -aG wheel buddha
su - buddha

# -- Miscellaneous user customization --
alias 'll'='ls -al'

# -- ENV VARIABLES --
export PATH="$PATH:/usr/local/bin:/opt/custom/bin"
export EDITOR="vi"
export HISTSIZE=10000
export HISTFILESIZE=20000
export LANG="en_US.UTF-8"
export TZ="America/New_York"
export LOGLEVEL="INFO"
export TMPDIR="/var/tmp"


# ===============
# -- Setup Git --
# ===============

## Clone Repo (recommended)
git clone https://github.com/NikonicSatori/TheBox.git

## Pull Git Repo (alternative method)
git init # sets up current directory as a Git repository
git remote add origin https://github.com/NikonicSatori/TheBox.git
git pull origin main



# (ssh key and clone)
# generate a new key pair (add the public key to github profile)
ssh-keygen -t ed25519 -C "id_ed25519_git" -f ~/.ssh/id_ed25519_git -N ""

# set default github.com key to use
echo -e 'Host github.com\n\tHostName github.com\n\tIdentityFile ~/.ssh/id_ed25519_git\n\tUser git' >> ~/.ssh/config

# *DO NOT USE*
# Clone Satoshi Palace Repo
#git clone -b patrick-nft git@github.com:SatoshisPalace/satoshisPalaceFrontEnd.git
#git clone git@github.com:SatoshisPalace/discord-bot.git

# -- SETUP NODEJS --
install nodejs -y
dnf install npm -y
cd ~/satoshisPalaceFrontEnd
npm install
npm run dev

# *** if node is out of date (>= 14.18.0), then upgrade node
node --version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 14.18.0


###
# -- clone & setup discord-bot
dnf install python3-pip -y
cd ~/discord-bot
pip3 install -r requirements
python3 -m bot


### -- echo IP address
ip_address=$(hostname -i)
echo "IP Address: $ip_address"







### -- interface setup --
# Remove the existing IP address from the interface
#ip addr del 172.17.0.2/16 dev eth0
# Add the new IP address to the interface
#ip addr add 172.17.0.21/16 dev eth0
# ^RTNETLINK answers: Operation not permitted
# Save the changes to the network configuration file to make them persistent
#echo -e "auto eth0\niface eth0 inet static\n  address 172.17.0.21\n  netmask 255.255.0.0\n" | sudo tee /etc/network/interfaces.d/eth0.conf > /dev/null
# Restart the network service to apply the changes
#systemctl restart networking



