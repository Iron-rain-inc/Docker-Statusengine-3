#Pull base image
FROM ubuntu:18.04

#Install dependencies
RUN apt-get update && \
	apt-get install tzdata && \
	apt-get install git \
	php-cli \
	php-zip \
	php-mysql \
	php-ldap \
	php-json \
	composer \ 
	apache2 \
	libapache2-mod-php \
	ssl-cert -y

#Install UI
RUN cd /usr/share/ && \
	git clone https://github.com/statusengine/interface.git statusengine-ui && \
	cd /usr/share/statusengine-ui && \
	chmod +x bin/* && \
	composer install 

COPY config.yml /usr/share/statusengine-ui/etc/config.yml

#Copy apace config
COPY statusengine-ui.conf /etc/apache2/sites-available/statusengine-ui.conf

#Set up apache
RUN a2ensite statusengine-ui && \
	a2enmod rewrite && \
	a2enmod ssl 

COPY entrypoint.sh /entrypoint.sh

CMD ./entrypoint.sh
