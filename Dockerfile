FROM opensuse/leap:15.0

MAINTAINER SIRS / docker-lizmap 

# Update repo
RUN zypper --non-interactive --no-gpg-checks ref
RUN zypper --non-interactive --no-gpg-checks update

# Install 
RUN zypper --non-interactive --no-gpg-checks in python-simplejson xauth htop vim curl ntp\
    apache2 apache2-mpm-worker apache2-mpm-prefork apache2-bin apache2-data ibapache2-mod-fcgid libapache2-mod-php7\
    php7 php7-common php7-cgi php7-curl php7-cli php7-sqlite php7-gd php7-pgsql unzip\
    &&  zypper clean \
    && rm -rf /var/cache/zypp/*

    
RUN a2dismod php5; a2enmod actions; a2enmod fcgid ; a2enmod ssl; a2enmod rewrite; a2enmod headers; \
    a2enmod deflate; a2enmod php5

ENV LIZMAPVERSION 3.2rc6

COPY files/ /home/files/

ADD https://github.com/3liz/lizmap-web-client/archive/$LIZMAPVERSION.zip /var/www/
RUN /home/files/setup.sh
    
VOLUME  ["/var/www/websig/lizmap/var" , "/home"] 
EXPOSE 80 443
CMD /start.sh
