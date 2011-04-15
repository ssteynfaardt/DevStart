#!/bin/bash
shopt -s nocasematch
ROOT_UID=0     # Only users with $UID 0 have root privileges.
E_NOTROOT=67   # Non-root exit error.

if [ "$UID" -ne "$ROOT_UID" ]
then
  echo -en '\E[0;31m'"\033[1mMust be root to run this script.\033[0m \n" 
  exit $E_NOTROOT
fi

#######################
# ZEND SERVER INSTALL #
#######################

echo -n "Zend Server 5.3 CE: [I]nstall, [U]pdate, [S]kip: "
read -e OPTION
if [ "$OPTION" = "i" ]; then
        echo "Installing Zend Server..."
        APT_ZEND="deb http://repos.zend.com/zend-server/deb server non-free"
        if [ `sudo cat /etc/apt/sources.list | grep "$APT_ZEND" | awk '{ print $1}'` != "deb" ]; then
          echo "$APT_ZEND"  >> /etc/apt/sources.list
          wget http://repos.zend.com/zend.key -O- | sudo apt-key add -
        fi
        aptitude update
        aptitude install zend-server-ce-php-5.3
        echo -en '\E[0;32m'"\033[1mZend...   [DONE]\033[0m \n"
        ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print "Complete the zend install @ http://" $1 ":10081/ZendServer"}'
elif [ "$OPTION" = "u" ]; then
        echo "Updating Zend Sever..."
        aptitude update
        aptitude upgrade
        aptitude install `dpkg --get-selections|grep zend| awk -F " " '{print $1}' |xargs`
        echo -en '\E[0;32m'"\033[1mZend...   [DONE]\033[0m \n"
fi

###################
# MONGODB INSTALL #
###################

echo -n "MongoDB Server: [I]nstall, [S]kip: "
read -e OPTION
if [ "$OPTION" = "i" ]; then
        echo "Installing MongoDB..."
        apt-get -y install tcsh git-core scons g++
        apt-get -y install libpcre++-dev libboost-dev libreadline-dev xulrunner-dev
        apt-get -y install libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-date-time-dev
        mkdir install
        cd install
        git clone git://github.com/mongodb/mongo.git
        cd mongo
        git tag -l
        echo -n "Select a version (eg. r1.8.1): "
        read -e VERSION
        git checkout "$VERSION"
        scons all
        scons --prefix=/usr install
        echo -en '\E[0;32m'"\033[1mMongoDB...   [DONE]\033[0m \n"
fi


####################
# MEMCACHE INSTALL #
####################

echo -n "Memcached Server: [I]nstall, [S]kip: "
read -e OPTION
if [ "$OPTION" = "i" ]; then
        sudo apt-get install memcached
        sudo apt-get install php-pear
        sudo apt-get install php5-dev
        sudo apt-get install libmemcached-dev
        sudo pecl install Memcache
	mkdir -p /etc/php5/apache2/conf.d
	sudo touch /etc/php5/apache2/conf.d/memcache.ini        
	sudo echo "extension=memcache.so" > /etc/php5/apache2/conf.d/memcache.ini
	if [ ! -e /usr/bin/php ]; then
     	sudo ln -s /usr/local/zend/bin/php /usr/bin/php
 	fi
	MEM_INI='memcache.hash_strategy="consistent"'
        if [ `sudo cat /usr/local/zend/etc/php.ini | grep "$MEM_INI" | awk '{ print $1}'` != "$MEM_INI" ]; then
          sudo echo "$MEM_INI" >> /usr/local/zend/etc/php.ini
        fi
        #memcached -d -u www-data -m 1024 -l 127.0.0.1 -p 11211
        #Since we are running this file as root tell memcache to run as www-data
        sudo memcached -d -u www-data -m 1024 -l 127.0.0.1 -p 11211
        /etc/init.d/apache2 restart
        echo -en '\E[0;32m'"\033[1mMemcached... [DONE]\033[0m \n"
fi

###################
# VARNISH INSTALL #
###################

echo -n "Varnish Proxy Server: [I]nstall, [S]kip: "
read -e OPTION
if [ "$OPTION" = "i" ]; then
        echo "Installing Varnish..."
	   APT_VARNISH="deb http://repo.varnish-cache.org/ubuntu/ $(lsb_release -s -c) varnish-2.1"
	   if [ `sudo cat /etc/apt/sources.list | grep "$APT_VARNISH" | awk '{ print $1}'` != "deb" ]; then
      	 sudo apt-get install curl
          curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
          echo "APT_VARNISH" >> /etc/apt/sources.list
        fi
        apt-get update
        apt-get install varnish
        echo -en '\E[0;32m'"\033[1mVarnish... [DONE]\033[0m \n"
fi