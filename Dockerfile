FROM debian:jessie
MAINTAINER "David Bătrânu" <david.batranu@eaudeweb.ro>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -q -y \
    postfix \
    dovecot-imapd \
    sqlite \
    apache2-mpm-event \
    php5 \
    php-pear \
    php5-mysql \
    php5-pgsql \
    php5-sqlite \
    rsyslog


RUN a2ensite 000-default && \
    a2enmod expires && \
    a2enmod headers

RUN pear install mail_mime mail_mimedecode net_smtp net_idna2-beta auth_sasl net_sieve crypt_gpg

WORKDIR /var/

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY postfix/* /etc/postfix/
COPY dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf

RUN postmap /etc/postfix/transport

COPY roundcubemail-1.1.2-complete.tar.gz /var/

RUN rm -rf www && \
    tar -zxf roundcubemail-1.1.2-complete.tar.gz && \
    mv roundcubemail-1.1.2 www && \
    rm -rf /var/www/installer && \
    mkdir /var/www/db && \
    . /etc/apache2/envvars && \
    chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www/temp /var/www/logs /var/www/db

RUN useradd -u 1000 -m -s /bin/bash mailtrap && \
    echo "mailtrap:mailtrap" | chpasswd && \
    chmod 777 -R /var/mail

COPY config.inc.php /var/www/config/

EXPOSE 25 80
CMD \
    service rsyslog start && \
    service postfix start && \
    service dovecot start && \
    service apache2 start && \
    tail -f /var/log/apache2/error.log -f /var/log/mail.log
