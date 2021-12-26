#! /bin/bash

## Run this simple script after a minimal installation of Debian Bullseye.
## WARNING! Тhis set of packages is NOT compatible with all hardware. Use it at your own risk.
## Everyone is free to modify, copy, use and distribute this simple script.

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

## Install Minimal Gnome Desktop, Mesa 3D Graphics Library, Bluetooth support, Printer support, PC/SC driver for USB CCID smart card readers, Multimedia codecs, Flatpak support, LibreOffice, Roboto and Awesome fonts, RAR and ZIP support, Java, Ruby.
sudo apt install --yes firmware-linux-nonfree firmware-iwlwifi firmware-realtek libatk-adaptor at-spi2-core adwaita-icon-theme fonts-cantarell caribou dconf-cli dconf-gsettings-backend eog evince evolution-data-server sound-theme-freedesktop gdm3 gedit glib-networking gnome-backgrounds gnome-bluetooth gnome-calculator gnome-characters gnome-contacts gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring libpam-gnome-keyring gnome-logs gnome-menus gnome-online-accounts gnome-online-miners gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-software gnome-system-monitor gnome-terminal gnome-themes-extra gnome-user-docs gnome-user-share gsettings-desktop-schemas gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-packagekit gstreamer1.0-pulseaudio gvfs-backends libglib2.0-bin gvfs-fuse libcanberra-pulse libproxy1-plugin-gsettings libproxy1-plugin-webkit librsvg2-common gkbd-capplet nautilus pulseaudio pulseaudio-module-bluetooth system-config-printer-common system-config-printer-udev gnome-sushi totem tracker yelp zenity desktop-base network-manager-gnome libproxy1-plugin-networkmanager file-roller gnome-color-manager gnome-screenshot gnome-weather orca rygel-playbin rygel-tracker avahi-daemon evolution gnome-tweaks libreoffice-gnome libreoffice-writer libreoffice-calc libreoffice-impress libgsf-bin rhythmbox seahorse xdg-user-dirs-gtk cups-pk-helper evolution-plugins gstreamer1.0-libav gstreamer1.0-plugins-ugly rhythmbox-plugins totem-plugins hunspell-en-us hyphen-en-us libreoffice-help-en-us xserver-xorg libgl1-mesa-glx libgl1-mesa-dri libglu1-mesa xfonts-base xfonts-100dpi xfonts-75dpi xfonts-scalable x11-apps x11-session-utils x11-utils x11-xkb-utils x11-xserver-utils xauth xinit xfonts-utils xkb-data xorg-docs-core mutter libd3dadapter9-mesa libegl-mesa0 libegl1-mesa libgl1-mesa-glx libglapi-mesa libgles2-mesa libglu1-mesa libglw1-mesa libglx-mesa0 libwayland-egl1-mesa mesa-opencl-icd mesa-utils mesa-utils-extra mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers vdpau-driver-all libvdpau-va-gl1 libvdpau1 vainfo libva-drm2 libva-glx2 libva-wayland2 libva-x11-2 libva2 libavcodec-extra ffmpeg build-essential fonts-roboto fonts-font-awesome zip unzip unrar p7zip p7zip-full p7zip-rar gnome-shell-extension-appindicator libayatana-appindicator3-1 ufw gufw linux-headers-amd64 flatpak gnome-software-plugin-flatpak printer-driver-all hp-ppd foomatic-db-engine openprinting-ppds cups cups-browsed system-config-printer ipp-usb printer-driver-cups-pdf sane sane-utils xsane xsane-common pcscd libccid libpcsclite1 default-jdk meson sassc bluez-tools bluetooth firefox-esr ruby ruby-dev;

## Install latest firmware.
#git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
#sudo cp -rfu linux-firmware/* /lib/firmware/
#sudo update-initramfs -u
#rm -rf linux-firmware

## Install MellowPlayer.
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/home_ColinDuquesnoy.gpg] https://download.opensuse.org/repositories/home:/ColinDuquesnoy/Debian_Unstable/ /' | sudo tee /etc/apt/sources.list.d/home:ColinDuquesnoy.list
curl -fsSL https://download.opensuse.org/repositories/home:ColinDuquesnoy/Debian_Unstable/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_ColinDuquesnoy.gpg > /dev/null
sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
sudo apt install --yes mellowplayer;
curl -s "https://gitlab.com/ColinDuquesnoy/MellowPlayer/-/raw/master/scripts/install-widevine.sh" | bash

## Install SublimeText.
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-pub.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/sublimehq-pub.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
sudo apt install --yes sublime-text;

## Install Google Chrome Web Browser.
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-linux_signing_key.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/google-linux_signing_key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt clean; sudo apt autoclean; sudo apt update; sudo apt upgrade -y; sudo apt install -f; sudo apt autoremove -y
sudo apt install -y google-chrome-stable;

## Enable Flathub repo.
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## Enable Driverless Printing
cat >> /etc/cups/cups-browsed.conf <<EOF
CreateIPPPrinterQueues All
CreateRemoteCUPSPrinterQueues No
EOF

exit 0
