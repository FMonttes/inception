FROM alpine:3.20

RUN apk update && \
    apk add --no-cache mariadb mariadb-client mariadb-openrc

# Create necessary directories and set permissions
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initial database setup
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql

COPY /entrypoint.sh /entrypoint.sh

ENV MYSQL_DATABASE=inception_db
ENV MYSQL_USER=felipe
ENV MYSQL_PASSWORD=123456
ENV MYSQL_ROOT_PASSWORD=123456

RUN chmod +x /entrypoint.sh

EXPOSE 3306

USER mysql

ENTRYPOINT ["/entrypoint.sh"]
