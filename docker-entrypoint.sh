#!/usr/bin/env bash

service rsyslog start
service postfix start
service dovecot start
service apache2 start

tail -f /var/log/apache2/error.log -f /var/log/mail.log
