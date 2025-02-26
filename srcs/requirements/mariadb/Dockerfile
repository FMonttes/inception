FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server procps

# Configura diretórios e permissões
RUN mkdir -p /var/run/mysqld /var/lib/mysql /usr/data && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql && \
    chmod 777 /var/run/mysqld

COPY ./tools/entrypoint.sh /entrypoint.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/init.sql /usr/data/init.sql

ENV MYSQL_DATABASE=inception_db \
    MYSQL_USER=felipe \
    MYSQL_PASSWORD=123456 \
    MYSQL_ROOT_PASSWORD=123456

RUN chmod +x /entrypoint.sh && \
    chmod 644 /usr/data/init.sql

EXPOSE 3306

ENTRYPOINT ["bash", "/entrypoint.sh"]
