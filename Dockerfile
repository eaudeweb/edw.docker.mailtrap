FROM debian:stable-slim

LABEL maintainer.original="David Batranu <david.batranu@eaudeweb.ro>"
LABEL maintainer.current="ipunkt Business Solutions <info@ipunkt.biz>"

ENV ROUNDCUBE_VERSION="1.3.1"
ENV DEBIAN_FRONTEND noninteractive

ENV MT_USER mailtrap
ENV MT_PASSWD mailtrap
ENV MT_MAILBOX_LIMIT 51200000
ENV MT_MESSAGE_LIMIT 10240000

RUN apt-get update && apt-get install -q -y \
    postfix \
    dovecot-imapd \
    sqlite \
    php \
    php-mbstring \
    php-sqlite3 \
    php-pear \
    rsyslog \
    wget \
    && \
    a2ensite 000-default && \
    a2enmod expires && \
    a2enmod headers

RUN pear channel-update pear.php.net && \
    pear install mail_mime mail_mimedecode net_smtp net_idna2-beta Auth_SASL Horde_ManageSieve crypt_gpg

WORKDIR /var/

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY postfix/* /etc/postfix/
COPY dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf

RUN wget https://github.com/roundcube/roundcubemail/releases/download/$ROUNDCUBE_VERSION/roundcubemail-$ROUNDCUBE_VERSION-complete.tar.gz -O roundcube.tar.gz && \
    rm -rf www && \
    tar -zxf roundcube.tar.gz && \
    mv roundcubemail-$ROUNDCUBE_VERSION www && \
    rm -rf /var/www/installer && \
    mkdir /var/www/db && \
    . /etc/apache2/envvars && \
    chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www/temp /var/www/logs /var/www/db && \
    chmod 777 -R /var/mail


COPY config.inc.php /var/www/config/
COPY docker-entrypoint.sh /var/local/
RUN chmod 777 /var/local/docker-entrypoint.sh

EXPOSE 25 80

ENTRYPOINT ["/var/local/docker-entrypoint.sh"]
