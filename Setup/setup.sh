#!/bin/bash

#First of all make this file as executable program by running command "chmod a+x setup.sh"
#you can remove any command below if you do not want to install that package
#Make sure you are in super user mode (by running command su) before running this file using "./setup.sh"


yum -y update


#Install gnome-tweak-tool
yum -y install gnome-tweak-tool


#WGET
yum -y install wget


#rpmfusion
#su -c 'yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://#download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

#Media codecs
yum -y install gstreamer gstreamer-plugins-good ffmpeg-libs xine-lib xine-lib-extras xine-lib-extras-freeworld xine-ui xine-ui-skins gxine gstreamer-plugins-#bad gstreamer-plugins-bad-free-extras gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer1-libav gstreamer1-plugins-bad-free-#extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-base-tools gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer1-plugins-bad-free #gstreamer1-plugins-good gstreamer1-plugins-base gstreamer1 ffmpeg libdvdread libdvdnav lsdvd libdvdcss

#vlc
yum -y install vlc

#Music player banshee
yum -y install banshee

#xbmc and minitube
yum -y install xbmc minitube

#rar utilities
yum -y install unrar p7zip p7zip-plugins

#filezilla
yum -y install filezilla

#gimp
yum -y install gimp

#inkscape
yum -y install inkscape

#blender
yum -y install blender

#flash player
#rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
yum -y install flash-plugin nspluginwrapper alsa-plugins-pulseaudio libcurl

#Google Chrome
yum -y install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

#Google-talk plugin
yum -y install https://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm

#haxe
sh ./install-haxe.sh

haxelib install lime
haxelib run lime setup
lime install openfl

#node
yum -y install npm
npm install -g grunt

#git
yum -y install git

#oh-my-zsh
yum -y install zsh
curl -L http://install.ohmyz.sh | sh

#wine
cd /home/shanej/Downloads
yum -y install wine
wget http://winetricks.org/winetricks
chmod +x winetricks
./winetricks wininit
sudo cp winetricks /usr/local/bin
echo 'export WINEDEBUG=fixme-all' >> ~/.bashrc

#air
cd /home/shanej/Libraries/actionscript
sudo mkdir air_sdk_3.9
cd air_sdk_3.9
sudo chown `whoami`:`whoami` .
wget http://airdownload.adobe.com/air/win/download/latest/AIRSDK_Compiler.zip
unzip AIRSDK_Compiler.zip
export AIR_HOME=/home/shanej/Libraries/actionscript/air_sdk_3.9
echo "export AIR_HOME=/home/shanej/Libraries/actionscript/air_sdk_3.9" >> ~/.bashrc

#java
tar -xvf /home/shanej/Scripts/Setup/jdk-7u45-linux-x64.tar.gz
sudo cp /home/shanej/Scripts/Setup/jdk1.7.0_45/. /usr/lib/jvm/jdk1.7.0
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.7.0/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.7.0/bin/javac" 1
sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.7.0/bin/javaws" 1
sudo update-alternatives --config java
sudo update-alternatives --config javac
sudo update-alternatives --config javaws 
echo 'export JAVA_HOME=/usr/lib/jvm/jdk1.7.0' >> ~/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc

#desktop files
sudo cp -a /home/shanej/Applications/desktop-files/. /home/shanej/.local/share/applications/

#gnome-do
yum -y install gnome-do

source ~/.bashrc

#bumblebee
su -c "yum install -y libbsd-devel libbsd glibc-devel libX11-devel help2man autoconf git tar glib2 glib2-devel kernel-devel kernel-headers automake gcc gtk2-#devel"
yum -y --nogpgcheck install http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee-nonfree/fedora20/noarch/bumblebee-nonfree-release-1.1-1.noarch.rpm
sudo yum install glibc-devel
yum -y install bumblebee-nvidia

#lampp
sudo yum -y install httpd
sudo service httpd start
sudo yum -y install mysql mysql-server
sudo service mysqld start
sudo /usr/bin/mysql_secure_installation
sudo yum -y install php php-mysql
sudo chkconfig httpd on
sudo chkconfig mariadb on

git clone git@github.com:jgillich/brackets-rpm.git
cd brackets-rpm
yum install -y ./brackets-0.41.0-13419.x86_64.rpm

#for brackets
ln -s /usr/lib64/libudev.so.1 /usr/lib64/libudev.so.0

cat 910-rat.conf >> /usr/share/X11/xorg.conf
echo "pointer = 1 2 3 4 5 6 7 8 9 10 11 12 0 0 0 0 0 0" >> /etc/X11/Xmodmap

#dropbox - goes last as it launches the application
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd


