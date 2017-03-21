#Basic script to install
#Author: Marcelo Diaz
#!/bin/bash

echo "******************************************************************************************************"
echo -e "\e[32m Welcome!"
echo -e "\e[32m To install \e[92m Otherstuff\e[39m"
echo "******************************************************************************************************"
echo ""
echo -e "\e[44m to be able to continue, it will be checked disk space and internet conection.\e[49m"
echo ""

FREE=`df --output=avail -h "$PWD" | sed '1d;s/[^0-9]//g'`
if [[ $FREE -gt 20 ]]; then
   echo -e "Disk space. \e[92m   [OK] \e[39m"
   echo ""
else 
   echo -e "\e[91m There is not space\e[39m. It will be not continue. " 
fi

/usr/bin/dpkg -i /dev/zero 2>/dev/null
if [ "$?" -eq 2 ]; then
    echo "There is an update process runnind, It will be not continue."
    echo "wait it finish and try again."
    exit
fi

echo -e "Check internet  \c"
ping -c 5 www.google.com>>/dev/null
if [ $? -eq  0 ]
   then
	echo -e "\e[92m [OK] \e[39m"
        echo ""
        /usr/bin/apt-get -y install dialog
   else
	echo -e "\e[91mThere is not internet connection. \e[39m. It wil be not continue.  "
        exit
fi
echo ""
echo "Checking Dialog (GUI Utility) it is necesary to be able continue."
file="/usr/bin/dialog"
if [ -f "$file" ]
then
	echo -e "Dialog \e[92m              [OK] \e[39m"
else
	echo -e "\e[91mDialog not found or was not install\e[39m"
fi

echo "******************************************************************************************************"
sleep 5 

dialog --title "Process to install..." \
--backtitle "Install" \
--yesno "It is everthing ok to install. ¿Do you want continue?" 7 60
response=$?
case $response in
   0) echo -e "\e[92m Continue to process to install.\e[39m";;
   1) exit;;
   255) echo "[ESC] key was touch.";;
esac

files='git libxml2-dev libxslt-dev libcurl4-openssl-dev'


dialog --title "Download files necessary" --gauge "Installing..." 10 75 < <(
 n=45
# n=6
 i=0 
 for f in build-essential git libxml2-dev libxslt-dev libcurl4-openssl-dev memcached libapr1-dev libaprutil1-dev apache2 bash curl patch bzip2 ca-certificates gawk g++ gcc make libc6-dev patch openssl ca-certificates libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev apache2-dev postgresql libpq-dev cmake unzip 
# for f in git libxml2-dev libxslt-dev libcurl4-openssl-dev postgresql libpq-dev
 do 
    # calculate progress
    PCT=$(( 100*(++i)/n ))
    # update dialog box 
cat <<EOF
XXX
$PCT
Install "$f"...
XXX
EOF
      # copy file $f to $DEST 
      /usr/bin/apt-get -y install $f  &>/dev/null
      #sleep 2
  done 
)
