#! /bin/bash

## Everyone is free to modify, copy, use and distribute this simple script.

## dmesg fix: "KillMode=none is deprecated" - plymouth-start.service 
sudo sed -i 's/KillMode=none/KillMode=control-group/g' /lib/systemd/system/plymouth-start.service

## View and manage network settings through Gnome Settings Panel.
sudo sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf

## dmesg fix: sp5100-tco: Watchdog hardware is disabled!
echo 'blacklist sp5100_tco' | sudo tee /etc/modprobe.d/sp5100_tco.conf 

## Custom grub settings.
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i8042.nopnp iommu=off"/g' /etc/default/grub
sudo update-grub

## Tuning terminal.
sudo gem install colorls
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k/powerlevel10k"/g' ~/.zshrc

cat >> ~/.zshrc <<EOF
neofetch
alias ll='colorls -lA --sd --gs --group-directories-first'
alias ls='colorls --group-directories-first'
source $(dirname $(gem which colorls))/tab_complete.sh
EOF

cat >> ~/.bashrc <<EOF
neofetch
alias ll='colorls -lA --sd --gs --group-directories-first'
alias ls='colorls --group-directories-first'
source $(dirname $(gem which colorls))/tab_complete.sh
EOF

git clone --depth=1 https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
./install.sh RobotoMono
sudo ./install.sh RobotoMono
./install.sh SpaceMono
sudo ./install.sh SpaceMono
cd && rm -rf nerd-fonts

## Install Adwaita++ icons.
wget -qO- https://raw.githubusercontent.com/Bonandry/adwaita-plus/master/install.sh | sh
wget -qO- https://git.io/fhQdI | sh
sudo suru-plus-folders -C indigo --theme Adwaita++
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita++-Colorful'

## Install SafenetAuthenticationClient for B-Trust Gemalto Token.
wget https://www.b-trust.bg/attachments/BtrustPrivateFile/28/docs/B-Trust-Gemalto-Linux-2020-05-28.tar
tar -xvf B-Trust-Gemalto-Linux-2020-05-28.tar
mv 'B-Trust_Gemalto_2020_05_28/DEB/Ubuntu 18.04/' B-Trust_Gemalto_2020_05_28/DEB/Ubuntu/
sudo apt install ~/B-Trust_Gemalto_2020_05_28/DEB/Ubuntu/Gemalto_Ubuntu_x64bit_18_04.deb
cd && rm -rf B-Trust_Gemalto_2020_05_28 && rm -rf B-Trust-Gemalto-Linux-2020-05-28.tar

## Install B-Trust BISS.
wget https://www.b-trust.bg/attachments/BtrustPrivateFile/24/docs/B-TrustBISS.tar
tar -xvf B-TrustBISS.tar
sudo apt install ~/btrustbiss.deb
cd && rm -rf btrustbiss.deb && rm -rf B-TrustBISS.tar

## Download B-Trust Certs.
mkdir -p ~/B-Trust-Certs-For-Firefox && cd ~/B-Trust-Certs-For-Firefox
wget http://ca.b-trust.org/repository/B-TrustRootQCA_DER.crt
wget http://ca.b-trust.org/repository/B-TrustRootACA_DER.crt
wget http://ca.b-trust.org/repository/ca5/RootCA5_DER.crt
wget http://ca.b-trust.org/repository/B-TrustOperationalQCA_DER.crt
wget http://ca.b-trust.org/repository/B-TrustOperationalACA_DER.crt
wget http://ca.b-trust.org/repository/ca5/OperCA5QES_DER.cer
wget http://ca.b-trust.org/repository/ca5/OperCA5AES_DER.cer
cd

#### Install Latest Mozilla Firefox Web Browser.
## wget -O firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=bg"
## sudo tar -jxvf firefox.tar.bz2 -C /opt
## sudo ln -s /opt/firefox/firefox /usr/bin/mozillafirefox
## sudo ln -s /opt/firefox/firefox /usr/local/bin/mozillafirefox
## sudo touch /usr/share/applications/mozillafirefox.desktop
## sudo cat >> /usr/share/applications/mozillafirefox.desktop <<EOF
## [Desktop Entry]
## Encoding=UTF-8
## Name=Mozilla Firefox
## Name[bg]=Mozilla Firefox
## Comment=Browse the World Wide Web
## Comment[bg]=Сърфиране в Мрежата
## GenericName=Web Browser
## GenericName[bg]=Интернет браузър
## X-GNOME-FullName=Mozilla Firefox Web Browser
## X-GNOME-FullName[bg]=Интернет браузър (Mozilla Firefox)
## Type=Application
## Terminal=false
## Exec=/usr/bin/mozillafirefox %u
## Icon=/opt/firefox/browser/chrome/icons/default/default128.png
## StartupNotify=true
## Categories=Network;WebBrowser;
## MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
## EOF
## sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/mozillafirefox 200 && sudo update-alternatives --set x-www-browser /usr/bin/mozillafirefox 

exit 0
