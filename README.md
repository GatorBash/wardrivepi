# Read Me

## About

This device is meant to be used for digital terrain mapping</br>
Its main fuctionallity comes from kismet</br>
The intent is for all of the file to be saved to the `/root/Desktop/Kismet/` folder</br>
this can be changed if you want but it is strongly recommended to save it in the `/root/` directory structure</br>
in this readme for your input to a command it will look like the following `<your input>`</br>

### File locations

After a successful run all of the files will be located in the `/root/Desktop/Kismet` folder</br>
Your survey data will be in several formats kismet, pcapng, and pcapppi</br>
most of your money will be made with the kismet file</br>
the kismet file can be converted into several different usefull file types for your needs</br>
the kismet.conf file is located in the `/etc/kismet/` directory</br>
the kismet_logging.conf is also located in the `/etc/kismet` directory</br>
if you want to make changes to what devices kismet uses you will need to edit the kismet.conf file</br>
if you want to change how kismet is saving files you will need to edit the kismet_logging.conf</br>

### kismet file types

the most common kismet file conversions are kml, pcap, and wiglecsv</br>
**kml**: these files work with most mapping software such as google-earth and gpsprune</br>
**pcap**: these files are the raw packet capture that was picked up, it will include wpa handshakes(if you caught any)</br>
and any other traffic that you may have captured</br>
**wiglecsv**: these files with take the data from the kismet file and put it into an excel type format</br>
displaying clients and waps(wireless access points)</br>

### Converting kismet files

kismet comes with numerous tools to convert the kismetdb file to different file types</br>
to convert these files it is a simple process</br>
to convert a kismet file to kml</br>
`kismetdb_to_kml --in <file name> --out <new file name you created>`</br>
to convert to pcap</br>
`kismetdb_to_pcap --in <file name> --out <new file name you created>`</br>
to convert to wiglecsv</br>
`kismetdb_to_wiglecsv --in <file name> --out <new file name you created>`</br>
if you plan to use any of these files in the future on windows make sure you put the right extention on the end of the file</br>
for example kml will be a `.kml`, pcap will be `.pcap`, and wiglecsv will be `.csv`</br>

## Set up

In order to set this thing up you will need a couple of things</br>
- an internet connection(you won't need it after setup)
- preferably a pi with kali pi imaged onto it

After the inital setup is complete in order to the run the device you</br>
will need at least one Alfa card and a gps puck</br>

You can run this script from anywhere on the device.</br>
It does not matter where you put it.</br>
all you need to do is make the script executable with</br>
`chmod +x install.sh`
then run the script with</br>
`sudo ./install.sh`
if you do not run it as sudo or are connected to the internet</br>
it will kick you back untill you to</br>

### Dual band Alfa card

If you have the new dual band alfa card you will need to download the driver</br>
to do this is a simple task</br>
run the following commands</br>
```
git clone https://github.com/aircrack-ng/rtl8812au
cd rtl8812au
sudo make
sudo make install
reboot
```
after that you should be good to use your new alfacard</br>

## Customization

### adding wifi sources
If you would like to add more wifi cards to this build you will just need to edit the `/etc/kismet/kismet.conf` file</br>
search for the line that contains `source=wlan0` and `source=wlan1`</br>
then insert the interface name that you want to add by adding a line bellow `source=wlan1` whith the following syntax</br>
`source=<interface name>`
If you want to add a bluetooth device apply the same logic as inputting a new wifi card</br>
Bluetooth devices can be found using `hciconfig`</br>
when you insert a bluetooth device you will use the interface that appears in the `hciconfig`</br>
i.e. hci0 will be the default first avalable interface</br>

## Running the device

before starting any run with the device you need to ensure that you have some things plugged in and ready to go</br>
- Alfa card (one min)
- GPS puck
</br>
Before doing any serious runs it will be important to do some test runs to make sure that everything is running correctly</br>
Before you start your run make sure the kismet service is running using `systemctl status kismet`</br>
It should show that it is running</br>
If you want to double down to make sure that it runs on boot run `systemctl enable kismet`</br>

## Trouble shooting and issues

When you first run the install script make sure that you give it some time once you connect to the internet</br>
If you don't do this then it can result in the device failing to install some of the software</br>
If you are already passed that point just rerun the script</br>
</br>
If you aren't capturing any data then make sure that your system can see your alfa card with `ip a`</br>
you should have two interfaces `wlan0` and `wlan1`</br>
If your alfa card isn't showing up check the model you are using, if you are using one of the new alfa cards</br>
that are dual band go back to the dual band alfa card section for the install other wise you will need to</br>
lookup the model number online to find the driver instructions</br>
</br>
If you aren't able to convert the kismet file to a kml you may be missing gps data</br>
make sure that the gps is plugged in and can see the sky and that `/dev/ttyUSB0` exists</br>
this can be done by running `ls /dev | grep ttyUSB0`</br>
If this doesn't return anything then make sure the gps puck is plugged in. If its plugged in and ttyUSB0</br>
still isn't there then try changing out your gps puck</br>
</br>
If you are finding more issues remeber that google is your friend</br>
You may also feel free to contact your support for this device</br>