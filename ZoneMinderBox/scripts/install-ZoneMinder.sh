#!/bin/bash

  #////////////////////////// < Install apache  > ///////////////////////////

  echo ">>>> install-ZoneMinder.sh: Install Apache.."
  pacman -S --noconfirm apache certbot certbot-apache

  echo ">>>> install-ZoneMinder.sh: Configure HTTPD-DEFAULT.."
  sed -i 's_ServerTokens Full_ServerTokens Prod_' /etc/httpd/conf/extra/httpd-default.conf

  echo ">>>> install-ZoneMinder.sh: Backing up HTTPD.."
  cp -avr /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.back

  echo ">>>> install-ZoneMinder.sh: Modify HTTPD config.."
  wget https://raw.githubusercontent.com/sh4rknado/ZoneMinderBox/master/srv/httpd.conf
  sleep 2
  mv httpd.conf /etc/httpd/conf/httpd.conf

  echo ">>>> install-ZoneMinder.sh: Autostart HTTPD.."
  systemctl enable httpd.service

  #////////////////////////// < Install PHP  > ///////////////////////////

  echo ">>>> install-ZoneMinder.sh: Install PHP with Library.."
  pacman -S --noconfirm php php-fpm php-gd php-apcu php-imagick php-cgi php-apache

  echo ">>>> install-ZoneMinder.sh: Autostart PHP-FPM.."
  systemctl enable php-fpm.service

  #////////////////////////// < Install MySQL  > ///////////////////////////

  echo ">>>> install-ZoneMinder.sh: Install Database MySQL (mariadb).."
  pacman -S --noconfirm mariadb galera python-mysql-connector python-mysqlclient

  echo ">>>> install-ZoneMinder.sh: Configure Engine Database MySQL.."
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

  echo ">>>> install-ZoneMinder.sh: Backing up MySQL.."
  cp -avr /etc/my.cnf /etc/my.cnf.bak

  echo ">>>> install-ZoneMinder.sh: Modify MySQL config.."
  wget https://raw.githubusercontent.com/sh4rknado/ZoneMinderBox/master/srv/my.cnf
  sleep 2
  mv my.cnf /etc/my.cnf

  echo ">>>> install-ZoneMinder.sh: Autostart MySQL.."
  systemctl enable mysqld.service
  systemctl start mysqld.service

  echo ">>>> install-ZoneMinder.sh: Running mysql_secure_install as manual Query.."
  # Make sure that NOBODY can access the server without a password
  mysql -e "UPDATE mysql.user SET Password = PASSWORD('vagrant') WHERE User = 'root'"
  # Kill the anonymous users
  mysql -e "DROP USER ''@'localhost'"
  # Because our hostname varies we'll use some Bash magic here.
  mysql -e "DROP USER ''@'$(hostname)'"
  # Kill off the demo database
  mysql -e "DROP DATABASE test"
  # Make our changes take effect
  mysql -e "FLUSH PRIVILEGES"
  # Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

  echo ">>>> install-ZoneMinder.sh: Restart MySQL deamon.."
  systemctl restart mysqld.service

  #////////////////////////// < Install Samba  > ///////////////////////////

  echo ">>>> install-ZoneMinder.sh: Install Samba.."
  pacman -S --noconfirm samba

  echo ">>>> install-ZoneMinder.sh: Add Samba Group.."
  groupadd sambashare

  echo ">>>> install-ZoneMinder.sh: Configure Samba Directory.."
  install --directory /mnt/video --owner=http --group=sambashare --mode=0777

  echo ">>>> install-ZoneMinder.sh: Configure Samba.."
  wget https://raw.githubusercontent.com/sh4rknado/ZoneMinderBox/master/srv/smb.conf
  sleep 2
  mv smb.conf /etc/samba/smb.conf

  echo ">>>> install-ZoneMinder.sh: Autostart samba.."
  systemctl enable smb.service
  systemctl enable nmb.service

  #////////////////////////// < Install Tools  > ///////////////////////////

  echo ">>>> install-ZoneMinder.sh: Install PHP Database Manager (phpmyadmin).."
  pacman -S --noconfirm phpmyadmin
