#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Initialize MySQL data directory
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start MySQL server temporarily
    mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
    pid="$!"

    # Wait for MySQL to start
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done

    # Set root password and create database/user
    mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Stop temporary MySQL server
    kill -s TERM "$pid"
    wait "$pid"
fi

# Start MySQL server
exec mysqld --user=mysql --datadir=/var/lib/mysql --console
```

3. Rebuild and run:

```bash
# Remove any existing containers and volumes
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker volume prune -f

# Build and run
docker build -t mariadb:v1 .
docker run -d \
    --name mariadb \
    -e MYSQL_DATABASE=inception_db \
    -e MYSQL_USER=felipe \
    -e MYSQL_PASSWORD=123456 \
    -e MYSQL_ROOT_PASSWORD=123456 \
    -p 3306:3306 \
    mariadb:v1
