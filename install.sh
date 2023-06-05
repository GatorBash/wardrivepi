#!/bin/bash

#making sure user is running it as root
if [ $UID != 0 ]
then
    echo "Run it as root"
    exit 1
fi

#making sure device is connected to the internet
if ! ping -c 1 8.8.8.8
then
    echo "Connect to the internet"
    exit 1
fi

#update repos
apt update -y
wait

#making install file
cat > /tmp/pkg << EOF
gpsd
gpsprune
gpsd-clients
zenity
kismet
tshark
tcpdump
autoconf
airgraph-ng
EOF

echo "Do you want to install libreoffice? y/n"
read libre
if [[ $libre == y ]]
then
    echo libreoffice >> /tmp/pkg
fi

#change passwords for root and kali
echo "create new password for root"
sleep 3
passwd root
echo "create new password for kali"
sleep 3
passwd kali

#create a desktop for root
mkdir /root/Desktop /root/Desktop/Kismet

#install software
for pkg in $(cat /tmp/pkg)
do
    if ! which $pkg
    then
        apt install $pkg -y
        wait
    fi
done

#config gpsd to use ttyUSB0
sed -i 's|DEVICES=""|DEVICES="/dev/ttyUSB0"|g' /etc/default/gpsd
sleep 2

#config kismet
cp /etc/kismet/kismet.conf /etc/kismet/kismetconf.backup
sed -i '/# source=wlan0:/c \\#' /etc/kismet/kismet.conf
sed -i '/# source=wlan0/c \\source=wlan0' /etc/kismet/kismet.conf
sed -i '/source=wlan0/a source=wlan1' /etc/kismet/kismet.conf
sed -i 's/# gps=gpsd/gps=gpsd/g' /etc/kismet/kismet.conf

#Direct log file to Kismet dir 
sed -i 's|log_prefix=./|log_prefix=/root/Desktop/Kismet/|g' /etc/kismet/kismet_logging.conf
sed -i 's/log_types=kismet/log_types=kismet,pcapng,pcapppi/g' /etc/kismet/kismet_logging.conf

#add root to kismet group
usermod -a -G kismet root

#disable logs 
systemctl mask syslog.socket rsyslog.service systemd-journald.service

#add alfa card driver install here
#git clone https://github.com/aircrack-ng/rtl8812au
#make -C rtl18812au/
#make install -C rtl18812au/

#enable services
systemctl enable kismet
systemctl enable gpsd

#reboot
reboot