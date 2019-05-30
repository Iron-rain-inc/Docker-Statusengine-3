#Pull base image
FROM ubuntu:18.04
#Install dependencies
RUN apt-get update && \ 
	apt-get install -y tzdata

RUN apt-get install git \
	gearman-job-server \
	libgearman-dev \
	gearman-tools \
	uuid-dev \
	libjson-c-dev \
	manpages-dev \
	build-essential \
	libglib2.0-dev \
	php-cli \
	php-zip \
	php-redis \
	redis-server \
	php-mysql \
	php-json \
	php-gearman \
	php-bcmath \
	php-mbstring \
	unzip \
	composer \ 
	build-essential \
	automake \
	gperf \
	help2man \
	libtool \
	libglib2.0-dev \ 
	monitoring-plugins \
	nagios-plugins* -y
#Create and copy source for broker
RUN cd /tmp && \
	git clone https://github.com/statusengine/module.git module && \
	cd module / && \ 
	make all && \
	mkdir -p /opt/statusengine/module && \
	cp /tmp/module/src/bin/nagios/statusengine.o /opt/statusengine/module/statusengine-nagios.o && \
	cp /tmp/module/src/bin/naemon/statusengine-1-0-5.o /opt/statusengine/module/statusengine-naemon-1-0-5.o

#Create from soruce for worker
RUN mkdir -p /opt/statusengine && \
	cd /opt/statusengine && \
	git clone https://github.com/statusengine/worker.git worker && \
	cd /opt/statusengine/worker && \
	chmod +x bin/* && \
	composer install && \
	cp /opt/statusengine/worker/lib/statusengine.init /etc/init.d/statusengine && \
	chmod +x /etc/init.d/statusengine 
 
RUN apt-get install wget

#Create naemon accounts and install 
RUN useradd naemon && \
	cd /tmp && \
	wget https://codeload.github.com/naemon/naemon-core/tar.gz/v1.0.10 && \
	tar xfv v1.0.10 && \
	cd naemon-core-1.0.10/ && \
	./autogen.sh --prefix=/opt/naemon --with-naemon-user=naemon --with-naemon-group=naemon --with-pluginsdir=/usr/lib/nagios/plugins && \
	make all && \
	make install

RUN mkdir -p /opt/naemon/var/ && \
	mkdir -p /opt/naemon/var/cache/nameon && \
	mkdir -p /opt/naemon/var/spool/checkresults && \
	chown naemon:naemon /opt/naemon/var -R && \
	mkdir /opt/naemon/etc/naemon/module-conf.d && \
	chown naemon:naemon /opt/naemon/etc -R



#Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
COPY redis.conf /etc/redis/redis.conf
#Expose gear
EXPOSE 4730

#Launch the app
CMD ./entrypoint.sh
