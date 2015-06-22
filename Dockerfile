FROM debian:jessie
MAINTAINER "David Bătrânu" <david.batranu@eaudeweb.ro>

EXPOSE 25 80

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
    php5-sqlite

ENV VERSION 1.1.2

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default

RUN a2enmod expires
RUN a2enmod headers

RUN pear install mail_mime mail_mimedecode net_smtp net_idna2-beta auth_sasl net_sieve crypt_gpg

WORKDIR /var/

ADD https://downloads.sourceforge.net/project/roundcubemail/roundcubemail/$VERSION/roundcubemail-$VERSION-complete.tar.gz /var/

RUN rm -rf www && \
    tar -zxvf roundcubemail-$VERSION-complete.tar.gz && \
    mv roundcubemail-$VERSION www

RUN echo -e '<?php\n$config = array();\n' > /var/www/config/config.inc.php
RUN rm -rf /var/www/installer

RUN . /etc/apache2/envvars && chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} /var/www/temp /var/www/logs

ENTRYPOINT [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]
CMD [ "-k", "start" ]
