# Statusengine 3 Docker Build

There are three docker containers required to run this build of Statusengine 3. 

<b>Database</b> - Built from the mysql:5.7 Docker image, pre-loaded with the required Statusengine 3 databases. <br>
                  The default is non-persistent volumes but the db data can be mounted persistently if required, <br>
                      see mysql Docker Hub for instructions.

<b>Engine</b> - Built form the Ubuntu 18.04 image, contains the broker module and the worker module. <br>
                The broker can be mapped to a host if not using the built in Naemon via,  <br>
                    `-v /opt/statusengine/module/statusengine-naemon-1-0-5.o:/opt/statusengine/module/statusengine-naemon-1-0-5.o`<br>                          or<br>
                    `-v /opt/statusengine/module/statusengine-nagios.o:/opt/statusengine/module/statusengine-nagios.o`<br>
                The worker and Naemon configuration are stored and mounted from the hosting machine and can be updated there. <br>
                The Naemon conf.d folder is also mounted from the hosting machine to allow updates.                 <br>
                The Naemon configuration must be updated for Gearman to publish to the SQL server if not used in the same Docker network. <br>
                
                
<b>UI</b> - Built from the Ubuntu 18.04 image, the default configuration file will look for the se-db docker container,<br>
              this must be changed to the DB hostname if not being used on the same docker host. <br>

## Standalone Launch

docker network create se

docker run -d -p 3306:3306 --name se-db --network se -e MYSQL_ROOT_PASSWORD=secret-password se-db:rc-01

docker run -d --name statusengine --network se -p 4730:4730 \  
    \
    -v "$(pwd)"/naemon.cfg:/opt/naemon/etc/naemon/naemon.cfg \
    -v "$(pwd)"/config.yml:/opt/statusengine/worker/etc/config.yml \
    -v "$(pwd)"/conf.d/:/opt/naemon/etc/naemon/conf.d" \    
    statusengine:rc-01

docker run -d -p 80:80 -p 443:443 --name se-ui -v "$(pwd)"/config.yml:/usr/share/statusengine-ui/etc/config.yml" --network se se-ui:rc-01

docker exec -t se-ui /usr/share/statusengine-ui/bin/Console.php users add --username "admin" --password "admin"

## Compose Launch
TBD

All credit for Statusengine to Daniel Ziegler | https://statusehttps://www.naemon.org/ngine.org 
All credit for Naemon to https://www.naemon.org/
