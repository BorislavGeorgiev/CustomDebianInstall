#! /bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

sudo apt update; sudo apt install --yes curl wget apt-transport-https dirmngr

sudo cp -fi /etc/apt/sources.list /etc/apt/sources.list.backup

sudo cat > /etc/apt/sources.list <<EOF
deb https://deb.debian.org/debian/ bullseye main contrib non-free
deb https://deb.debian.org/debian/ bullseye-updates main contrib non-free
deb https://deb.debian.org/debian-security bullseye-security main contrib non-free
deb https://deb.debian.org/debian bullseye-backports main contrib non-free
EOF

sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
 
exit 0
