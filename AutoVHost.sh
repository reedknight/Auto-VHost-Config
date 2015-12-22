#!/bin/bash

# @Author : Shaswata Dutta
# A script to automatically setup apache(httpd) virtual hosts
# Currently developing only for apache 2.4 on Fedora 23

# Invocation ./AutoVHost.sh test.example.com

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

if [[ -z "$1" ]]; then
    echo "Please provide virtual host name:"
    echo "sudo ./AutoVHost.sh test.example.com"
    exit 1
fi

vhost_name="$1"

# Creating .conf file

vhost_dir="/etc/httpd/vhost"

mkdir -p "$vhost_dir"

vhost_conf="$vhost_dir/$vhost_name-vhost.conf"

if [ -f $vhost_conf ]; then
    echo "A virtual host config file of same name already exists!"
    exit 1
fi

touch $vhost_conf

## HERE GOES THE TEMPLATE
cat > $vhost_conf <<EOF
NameVirtualHost $vhost_name:80

<VirtualHost $vhost_name:80>
    ServerAdmin webmaster@penguin.example.com
    DocumentRoot /var/www/$vhost_name/public_html
    ServerName $vhost_name:80
    ErrorLog logs/$vhost_name-error_log
    CustomLog logs/$vhost_name-access_log common
</VirtualHost>
EOF
## TEMPLATE ENDS

# Creating web root for vhost

mkdir /var/www/$vhost_name

if [ $? -ne 0 ] ; then
    #echo "Failed to create directory for virtual host"
    exit 1
fi

mkdir /var/www/$vhost_name/public_html


## DEFAULT HTML TEMPLATE
cat > /var/www/$vhost_name/public_html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>VHOST : $vhost_name</title>
</head>
<body>
    <h1>Virtual Host : $vhost_name</h1>
    <p>The virtual host $vhost_name was created using AutoVHost.sh</p>
    <p>AutoVHost is created by <i>Shaswata Dutta</i></p>
</body>
</html>
EOF
## TEMPLATE ENDS

echo "Mission Successful! Configure hosts file and restart Apache!"




