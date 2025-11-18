#!/bin/bash

set -e

mkdir -p /run/mysqld

chown mysql:mysql /run/mysqld


TMP_FILE=/tmp/init.sql

cat > "$TMP_FILE" <<EOF
CREATE DATABASE IF NOT EXISTS \`$MARIADB_DATABASE\`;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'localhost' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MARIADB_DATABASE\`.* TO '$MARIADB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF


exec mysqld
