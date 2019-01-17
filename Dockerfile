FROM opensuse/leap:15.0

MAINTAINER SIRS / docker-lizmap 

# Update repo
RUN zypper --non-interactive --no-gpg-checks ref
RUN zypper --non-interactive --no-gpg-checks update

# Install 
RUN zypper --non-interactive --no-gpg-checks in python-simplejson xauth htop vim curl ntp ntpdate ssl-cert\
    apache2 libapache2-mod-fcgid libapache2-mod-php5 \
    php5 php5-common php5-cgi php5-curl php5-cli php5-sqlite php5-gd php5-pgsql unzip\
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
