#!/bin/bash

# Verifica se o banco de dados já foi inicializado
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # Inicializa o banco de dados
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Substitui variáveis de ambiente no arquivo init.sql
    sed -i "s/\${MYSQL_DATABASE}/$MYSQL_DATABASE/g" /usr/data/init.sql
    sed -i "s/\${MYSQL_USER}/$MYSQL_USER/g" /usr/data/init.sql
    sed -i "s/\${MYSQL_PASSWORD}/$MYSQL_PASSWORD/g" /usr/data/init.sql
    sed -i "s/\${MYSQL_ROOT_PASSWORD}/$MYSQL_ROOT_PASSWORD/g" /usr/data/init.sql
fi

# Inicia o MariaDB em primeiro plano
exec mysqld --user=mysql --console
