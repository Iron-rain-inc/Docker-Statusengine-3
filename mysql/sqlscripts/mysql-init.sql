CREATE USER 'statusengine'@'%' IDENTIFIED BY 'SEUSERP@ssw0rd';
CREATE DATABASE IF NOT EXISTS `statusengine` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON `statusengine`.* TO 'statusengine'@'%';
