
echo ">>>> install-aur.sh: Get yay Source (aur-helpers).."
cd /opt
git clone https://aur.archlinux.org/yay.git
chown -R vagrant:vagrant /opt
chown -R vagrant:vagrant /home/vagrant

echo ">>>> install-aur.sh: Build yay (aur-helpers).."
su - vagrant -c "cd /opt/yay; makepkg -si --noconfirm"

echo ">>>> install-aur.sh: Cleanning Build.."
cd
rm -rf /opt/yay

echo ">>>> install-aur.sh: Install ZoneMinder.."
su - vagrant -c "yay -S zoneminder --noconfirm"

echo ">>>> install-aur.sh: Autostart ZoneMinder Service.."
systemctl enable zoneminder.service

echo ">>>> install-aur.sh: Create ZoneMinder Database.."
mysql -u root -pvagrant -e "CREATE DATABASE zm;"
mysql -u root -pvagrant -e "CREATE USER 'zmuser'@'localhost' IDENTIFIED BY 'zmpass';"
mysql -u root -pvagrant -e "GRANT ALL ON zm.* TO 'zmuser'@'localhost';"

echo ">>>> install-aur.sh: Modify the ZoneMinder VHOST.."
wget https://raw.githubusercontent.com/sh4rknado/ZoneMinderBox/master/srv/zoneminder.conf
sleep 2
cp -avr zoneminder.conf /etc/httpd/conf/extra/zoneminder.conf

echo ">>>> install-aur.sh: Add New Jennov PTZ Controle.."
wget https://raw.githubusercontent.com/sh4rknado/ZoneMinderBox/master/srv/jennov.pm
sleep 2
cp -avr jennov.pm /usr/share/perl5/vendor_perl/ZoneMinder/Control/jennov.pm

echo ">>>> install-aur.sh: Initialize ZoneMinder database.."
wget https://raw.githubusercontent.com/sh4rknado/ZoneMinderBox/master/srv/zm_backup.sql
sleep 2
sudo mysql -u root -pvagrant zm < zm_backup.sql

echo ">>>> install-aur.sh: Install System-Backup.."
su - vagrant -c "yay -S --noconfirm timeshift"


echo ">>>> install-aur.sh: Initialize perl dependency.."
yes 'y' | perl -MCPAN -e "install Digest::SHA1"
perl -MCPAN -e "install Crypt::MySQL"
perl -MCPAN -e "install Config::IniFiles"
perl -MCPAN -e "install Crypt::Eksblowfish::Bcrypt"
perl -MCPAN -e "install Net::WebSocket::Server"
perl -MCPAN -e "install LWP::Protocol::https"
perl -MCPAN -e "install Net::MQTT::Simple"
yes 'y' | perl -MCPAN -e "install JSON::XS"

echo ">>>> install-aur.sh: Install zmeventnotification dependency.."
su - vagrant -c "yay -S --noconfirm python-pyzm-git"
su - vagrant -c "yay -S --noconfirm  perl-config-inifiles"
su - vagrant -c "yay -S --noconfirm  perl-net-mqtt-simple"
su - vagrant -c "yay -S --noconfirm  perl-protocol-websocket"
su - vagrant -c "yay -S --noconfirm  perl-net-websocket-server"
su - vagrant -c "yay -S --noconfirm  python-dlib"
su - vagrant -c "yay -S --noconfirm  python-face_recognition_models"
su - vagrant -c "yay -S --noconfirm  python-face_recognition"
su - vagrant -c "yay -S --noconfirm  python-gifsicle"
su - vagrant -c "yay -S --noconfirm  python-imageio"
su - vagrant -c "yay -S --noconfirm  python-imageio-ffmpeg"
su - vagrant -c "yay -S --noconfirm  python-imutils"

echo ">>>> install-aur.sh: Build & Install zmeventnotification.."
yay -S --noconfirm zmeventnotification
