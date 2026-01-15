#!/usr/bin/env bash
set -e

mkdir -p /run/mysqld /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Listen on all interfaces
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf || true

# Initialize system DB if missing
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB system tables..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm
fi

# Create WordPress DB and users only once
if [ ! -d "/var/lib/mysql/${DATABASE}" ]; then
    echo "Setting up WordPress database and users..."

cat > /tmp/init.sql <<EOF
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS \`${DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DATABASE}\`.* TO '${WORDPRESS_DB_USER}'@'%';

FLUSH PRIVILEGES;
EOF

mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap < /tmp/init.sql
rm -f /tmp/init.sql
fi

exec mysqld_safe --datadir=/var/lib/mysql
