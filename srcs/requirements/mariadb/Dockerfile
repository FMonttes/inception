FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y;\
    apt install -y mariadb-server

RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Initial database setup
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql

COPY ./tools/entrypoint.sh /entrypoint.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d

ENV MYSQL_DATABASE=inception_db
ENV MYSQL_USER=felipe
ENV MYSQL_PASSWORD=123456
ENV MYSQL_ROOT_PASSWORD=123456

RUN chmod +x /entrypoint.sh

EXPOSE 3306

USER root

ENTRYPOINT ["/entrypoint.sh"]
