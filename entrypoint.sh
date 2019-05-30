#!/bin/sh
/usr/sbin/gearmand &
/usr/sbin/gearmand &
/etc/init.d/redis-server start
/etc/init.d/statusengine start
su naemon -c '/opt/naemon/bin/naemon /opt/naemon/etc/naemon/naemon.cfg'
bash
