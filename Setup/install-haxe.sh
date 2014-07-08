#!/bin/sh



read -p "Do you want to install Haxe 3 and Neko 2? (y/n) " RESP

if [ $RESP = "y" ]; then
	
	
	if [ -n "$(command -v yum)" ]; then
		
		echo ""
		echo "-----------------------------------"
		echo "    Installing Dependencies"
		echo "-----------------------------------"
		
		sudo yum -y install wget
		
	elif [ -n "$(command -v pacman)" ]; then
		
		echo ""
		echo "-----------------------------------"
		echo "    Installing Dependencies"
		echo "-----------------------------------"
		
		set -e
		sudo pacman -S wget --noconfirm
		
	elif [ -n "$(command -v apt-get)" ]; then
		
		echo ""
		echo "-----------------------------------"
		echo "    Removing Haxe (if installed)"
		echo "-----------------------------------"
		
		set +e
		sudo apt-get remove haxe neko
		set -e
		
	fi
	
	
	if [ `uname -m` = "x86_64" ]; then
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Downloading Neko (64-bit)"
		echo "-----------------------------------"	
	
		wget -c http://nekovm.org/_media/neko-2.0.0-linux64.tar.gz
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Installing Neko"
		echo "-----------------------------------"
		
		# Extract and copy files to /usr/lib/neko
		
		tar xvzf neko-2.0.0-linux64.tar.gz
		sudo mkdir -p /usr/lib/neko
		sudo rm -rf /usr/lib/neko/neko
		sudo rm -rf /usr/lib/neko/nekotools
		sudo cp -r neko-2.0.0-linux/* /usr/lib/neko
		
		# Add symlinks
		
		sudo rm -rf /usr/bin/neko
		sudo rm -rf /usr/bin/nekoc
		sudo rm -rf /usr/bin/nekotools
		sudo rm -rf /usr/lib/libneko.so
		
		sudo ln -s /usr/lib/neko/libneko.so /usr/lib/libneko.so
		sudo ln -s /usr/lib/neko/neko /usr/bin/neko
		sudo ln -s /usr/lib/neko/nekoc /usr/bin/nekoc
		sudo ln -s /usr/lib/neko/nekotools /usr/bin/nekotools
		
		if [ -d "/usr/lib64" ]; then
			
			set +e
			sudo rm -rf /usr/lib64/libneko.so
			sudo ln -s /usr/lib/neko/libneko.so /usr/lib64/libneko.so
			set -e
			
		fi
		
		# Cleanup
		
		rm -rf neko-2.0.0-linux
		rm neko-2.0.0-linux64.tar.gz
		
		
	else
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Downloading Neko (32-bit)"
		echo "-----------------------------------"	
		
		wget -c http://nekovm.org/_media/neko-2.0.0-linux.tar.gz
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Installing Neko"
		echo "-----------------------------------"
		
		
		# Extract and copy files to /usr/lib/neko
		
		tar xvzf neko-2.0.0-linux.tar.gz
		sudo mkdir -p /usr/lib/neko
		sudo rm -rf /usr/lib/neko/neko
		sudo rm -rf /usr/lib/neko/nekotools
		sudo cp -r neko-2.0.0-linux/* /usr/lib/neko
		
		# Add symlinks
		
		sudo rm -rf /usr/bin/neko
		sudo rm -rf /usr/bin/nekoc
		sudo rm -rf /usr/bin/nekotools
		sudo rm -rf /usr/lib/libneko.so
		
		sudo ln -s /usr/lib/neko/neko /usr/bin/neko
		sudo ln -s /usr/lib/neko/nekoc /usr/bin/nekoc
		sudo ln -s /usr/lib/neko/nekotools /usr/bin/nekotools
		sudo ln -s /usr/lib/neko/libneko.so /usr/lib/libneko.so
		
		
		# Cleanup
		
		rm -rf neko-2.0.0-linux
		rm neko-2.0.0-linux.tar.gz
		
		
	fi
	
	
	# Install libgc, which is required for Neko
	
	if [ -n "$(command -v yum)" ]; then
		
		sudo yum -y install libgc
		
	elif [ -n "$(command -v pacman)" ]; then
		
		sudo pacman -S gc --noconfirm
		
	elif [ -n "$(command -v zypper)" ]; then
		
		sudo zypper --non-interactive install libgc1
		
	else
		
		sudo apt-get -y install libgc-dev
		
	fi
	
	if [ -d "/usr/lib64" ] && [ ! -f "/usr/lib64/libpcre.so.3" ]; then
		
		set +e
		sudo ln -s /usr/lib64/libpcre.so.1 /usr/lib64/libpcre.so.3
		set -e
		
	fi
	
	if [ `uname -m` = "x86_64" ]; then
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Downloading Haxe (64-bit)"
		echo "-----------------------------------"	
		
		wget -c http://haxe.org/file/haxe-3.0.1-linux64.tar.gz
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Installing Haxe"
		echo "-----------------------------------"
		
		
		# Extract and copy files to /usr/lib/haxe
		
		sudo mkdir -p /usr/lib/haxe
		sudo rm -rf /usr/lib/haxe/haxe
		sudo tar xvzf haxe-3.0.1-linux64.tar.gz -C /usr/lib/haxe
		
		
		# Add symlinks
		
		sudo rm -rf /usr/bin/haxe
		sudo rm -rf /usr/bin/haxelib
		sudo rm -rf /usr/bin/haxedoc
		
		if [ -d "/usr/lib/haxe/build" ]; then
			
			sudo cp -rf /usr/lib/haxe/build/* /usr/lib/haxe/
			sudo rm -rf /usr/lib/haxe/build
			
		fi
		
		sudo ln -s /usr/lib/haxe/haxe /usr/bin/haxe
		sudo ln -s /usr/lib/haxe/haxelib /usr/bin/haxelib
		sudo ln -s /usr/lib/haxe/haxedoc /usr/bin/haxedoc
		
		
		# Set up haxelib
		
		sudo mkdir -p /usr/lib/haxe/lib
		sudo chmod -R 777 /usr/lib/haxe/lib
		haxelib setup /usr/lib/haxe/lib
		
		
		# Cleanup
		
		rm -rf haxe-3.0.1-linux64
		rm haxe-3.0.1-linux64.tar.gz
		
		
	else
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Downloading Haxe (32-bit)"
		echo "-----------------------------------"	
		
		wget -c http://haxe.org/file/haxe-3.0.1-linux32.tar.gz
		
		
		echo ""
		echo "-----------------------------------"
		echo "    Installing Haxe"
		echo "-----------------------------------"
		
		
		# Extract and copy files to /usr/lib/haxe
		
		sudo mkdir -p /usr/lib/haxe
		sudo rm -rf /usr/lib/haxe/haxe
		sudo tar xvzf haxe-3.0.1-linux32.tar.gz -C /usr/lib/haxe
		
		
		# Add symlinks
		
		sudo rm -rf /usr/bin/haxe
		sudo rm -rf /usr/bin/haxelib
		sudo rm -rf /usr/bin/haxedoc
		
		if [ -d "/usr/lib/haxe/build" ]; then
			
			sudo cp -rf /usr/lib/haxe/build/* /usr/lib/haxe/
			sudo rm -rf /usr/lib/haxe/build
			
		fi
		
		sudo cp /usr/lib/haxe/std/tools/haxelib/haxelib /usr/lib/haxe/haxelib
		
		sudo ln -s /usr/lib/haxe/haxe /usr/bin/haxe
		sudo ln -s /usr/lib/haxe/haxelib /usr/bin/haxelib
		sudo ln -s /usr/lib/haxe/haxedoc /usr/bin/haxedoc
		
		
		# Set up haxelib
		
		sudo mkdir -p /usr/lib/haxe/lib
		sudo chmod -R 777 /usr/lib/haxe/lib
		sudo haxelib setup /usr/lib/haxe/lib
		
		
		# Cleanup
		
		rm -rf haxe-3.0.1-linux32
		rm haxe-3.0.1-linux32.tar.gz
		
		
	fi
	
	
fi


echo ""
