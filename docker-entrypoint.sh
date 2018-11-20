#!/usr/bin/env bash

# setup roundcube des_key
RC_DES_KEY=`cat /dev/urandom | head -n 256 | sha256sum | awk '{print $1}'`;
sed -i "s/###DES_KEY###/$RC_DES_KEY/" /var/www/config/config.inc.php

# setup user account
if $(id 1000 > /dev/null 2>&1);
  then
    echo "User 1000 already exists - $(getent passwd 1000 | awk -F ':' '{print $1}'), skipping creation."
  else
    echo "Creating user 1000: $MT_USER!"
    useradd -u 1000 -m -s /bin/bash $MT_USER && echo "$MT_USER:$MT_PASSWD" | chpasswd
    sed -i "s/###MT_USER###/$MT_USER/" /etc/postfix/transport
    sed -i "s/###MT_USER###/$MT_USER/" /etc/postfix/main.cf
    sed -i "s/###MT_MAILBOX_LIMIT###/$MT_MAILBOX_LIMIT/" /etc/postfix/main.cf
    sed -i "s/###MT_MESSAGE_LIMIT###/$MT_MESSAGE_LIMIT/" /etc/postfix/main.cf
    postmap /etc/postfix/transport
fi


service rsyslog start
service postfix start
service dovecot start
service apache2 start

tail -f /var/log/apache2/error.log -f /var/log/mail.log
