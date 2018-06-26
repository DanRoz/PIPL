#!/bin/bash
BASE_PATH=$(dirname $0)

sleep 60

mysql --host mysqlslave -uroot -ppassword -AN -e 'STOP SLAVE;';
mysql --host mysqlslave -uroot -ppassword -AN -e 'RESET SLAVE ALL;';

mysql --host mysqlmaster -uroot -ppassword -AN -e "CREATE USER 'slave'@'%';"
mysql --host mysqlmaster -uroot -ppassword -AN -e "GRANT REPLICATION SLAVE ON *.* TO 'slave'@'%' IDENTIFIED BY 'password';"
mysql --host mysqlmaster -uroot -ppassword -AN -e 'flush privileges;'


MYSQL01_Position=$(eval "mysql --host mysqlmaster -uroot -ppassword -e 'show master status \G' | grep Position | sed -n -e 's/^.*: //p'")
MYSQL01_File=$(eval "mysql --host mysqlmaster -uroot -ppassword -e 'show master status \G'     | grep File     | sed -n -e 's/^.*: //p'")
mysql --host mysqlslave -uroot -ppassword -AN -e "CHANGE MASTER TO master_host='mysqlmaster', master_port=3306, \
        master_user='slave', master_password='password', master_log_file='$MYSQL01_File', \
        master_log_pos=$MYSQL01_Position;"

mysql --host mysqlslave -uroot -ppassword -AN -e "start slave;"

mysql --host mysqlmaster -uroot -ppassword -AN -e 'set GLOBAL max_connections=2000';
mysql --host mysqlslave -uroot -ppassword -AN -e 'set GLOBAL max_connections=2000';

