#!/bin/sh

echo "Iniciando MariaDB..."

# Inicializar banco de dados se ainda não existir
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Iniciar MariaDB temporariamente
mysqld --datadir=/var/lib/mysql --skip-networking &
sleep 5

# Criar banco de dados e usuário se ainda não existir
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS inception_db;
CREATE USER IF NOT EXISTS 'felipe'@'%' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON inception_db.* TO 'felipe'@'%';
FLUSH PRIVILEGES;
EOF

# Parar o processo temporário
mysqladmin -u root shutdown

# Iniciar MariaDB no modo foreground
exec mariadbd --datadir=/var/lib/mysql
