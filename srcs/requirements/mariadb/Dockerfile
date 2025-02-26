FROM alpine:3.20

RUN apk update && \
apk add --no-cache mariadb mariadb-client mariadb-openrc

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
chown -R mysql:mysql /var/lib/mysql

COPY /entrypoint.sh /entrypoint.sh

ENV MYSQL_ROOT_PASSWORD=123456

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "/entrypoint.sh" ]