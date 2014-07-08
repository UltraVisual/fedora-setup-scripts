#!/bin/bash

#lampp
rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm 
rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

yum -y --enablerepo=remi install phpmyadmin

httpd restart





