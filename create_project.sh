NAME="fmontes"
NICKNAME="fmontes"
DB_PW="123456"
DB_ROOT_PW="123456"
WP_USERPASS="123456"
ADM_WP_PASS="123456"

mkdir inception_42
mkdir inception_42/srcs
mkdir inception_42/secrets
echo "secrets" > inception_42/.gitignore

touch inception_42/Makefile
mkdir inception_42/srcs/requirements
touch inception_42/srcs/docker-compose.yml

mkdir inception_42/srcs/requirements/mariadb
mkdir inception_42/srcs/requirements/mariadb/conf
touch inception_42/srcs/requirements/mariadb/conf/create_db.sh
mkdir inception_42/srcs/requirements/mariadb/tools
touch inception_42/srcs/requirements/mariadb/tools/.gitkeep
touch inception_42/srcs/requirements/mariadb/Dockerfile
mkdir inception_42/srcs/requirements/nginx
mkdir inception_42/srcs/requirements/nginx/conf
touch inception_42/srcs/requirements/nginx/conf/nginx.conf
mkdir inception_42/srcs/requirements/nginx/tools
touch inception_42/srcs/requirements/nginx/tools/.gitkeep
touch inception_42/srcs/requirements/nginx/Dockerfile
mkdir inception_42/srcs/requirements/tools
touch inception_42/srcs/requirements/tools/.gitkeep
mkdir inception_42/srcs/requirements/wordpress
mkdir inception_42/srcs/requirements/wordpress/conf
touch inception_42/srcs/requirements/wordpress/conf/wp-config-create.sh
mkdir inception_42/srcs/requirements/wordpress/tools
touch inception_42/srcs/requirements/wordpress/tools/.gitkeep
touch inception_42/srcs/requirements/wordpress/Dockerfile

touch inception_42/secrets/credentials.txt

echo "DOMAIN_NAME=$NICKNAME.42.fr" > inception_42/secrets/credentials.txt
echo "CERT_=./requirements/tools/$NICKNAME.42.fr.crt" >> inception_42/secrets/credentials.txt
echo "KEY_=./requirements/tools/$NICKNAME.42.fr.key" >> inception_42/secrets/credentials.txt
echo "DB_NAME=wordpress" >> inception_42/secrets/credentials.txt
echo "DB_USER=wpuser" >> inception_42/secrets/credentials.txt
echo "DB_HOST=mariadb" >> inception_42/secrets/credentials.txt
echo "WP_TITLE=INCEPTION_$NAME" >> inception_42/secrets/credentials.txt
echo "WP_USERNAME=$NAME" >> inception_42/secrets/credentials.txt
echo "WP_USEREMAIL=$NAME@42.fr" >> inception_42/secrets/credentials.txt
echo "WP_USERPASS=$NAME" >> inception_42/secrets/credentials.txt
echo "WP_HOST=$NICKNAME.42.fr" >> inception_42/secrets/credentials.txt
echo "ADM_WP_NAME=$NAME" >> inception_42/secrets/credentials.txt
echo "ADM_WP_EMAIL=$NAME@42.fr" >> inception_42/secrets/credentials.txt

echo $DB_PW > inception_42/secrets/db_password.txt
echo $DB_ROOT_PW > inception_42/secrets/db_root_password.txt
echo $WP_USERPASS > inception_42/secrets/wp_password.txt
echo $ADM_WP_PASS > inception_42/secrets/adm_wp_password.txt

echo '#!/bin/bash

cp secrets/credentials.txt srcs/.env
DB_PASSWORD_FILE=$(cat "secrets/db_root_password.txt")
echo "DB_ROOT=$DB_PASSWORD_FILE" >> srcs/.env
DB_PASSWORD_FILE=$(cat "secrets/wp_password.txt")
echo "WP_USERPASS=$DB_PASSWORD_FILE" >> srcs/.env
DB_PASSWORD_FILE=$(cat "secrets/db_password.txt")
echo "DB_PASS=$DB_PASSWORD_FILE" >> srcs/.env
DB_PASSWORD_FILE=$(cat "secrets/adm_wp_password.txt")
echo "ADM_WP_PASS=$DB_PASSWORD_FILE" >> srcs/.env' > inception_42/make_env.sh

chmod +x inception_42/make_env.sh
