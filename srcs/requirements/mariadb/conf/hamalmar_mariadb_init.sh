#!/usr/bin/env bash
set -e

DB_INSTALL="/var/lib/mysql"
DB_CONF_ROUTE="/etc/mysql/mariadb.conf.d/50-server.cnf"

# Create run directory and set owner
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Ensure config file has [mysqld] section
if ! grep -q "^\[mysqld\]" "$DB_CONF_ROUTE"; then
    echo "[mysqld]" >> "$DB_CONF_ROUTE"
fi

# Set bind-address to 0.0.0.0
if ! grep -q "^bind-address=0.0.0.0" "$DB_CONF_ROUTE"; then
    echo "bind-address=0.0.0.0" >> "$DB_CONF_ROUTE"
fi

# Ensure port is 3306
if grep -q "^# port = 3306" "$DB_CONF_ROUTE"; then
    sed -i 's/^# port = 3306/port = 3306/' "$DB_CONF_ROUTE"
fi

# Replace 127.0.0.1 with 0.0.0.0 if present
if grep -q "127.0.0.1" "$DB_CONF_ROUTE"; then
    sed -i 's/127.0.0.1/0.0.0.0/' "$DB_CONF_ROUTE"
fi

# Initialize database if empty
if [ ! -d "$DB_INSTALL/mysql" ]; then
    mysql_install_db --user=mysql --datadir="$DB_INSTALL" --rpm --auth-root-authentication-method=normal
fi

# Create initialization SQL
cat > /tmp/init.sql <<-EOSQL
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
CREATE USER IF NOT EXISTS '${WP_ADMIN_USER}'@'%' IDENTIFIED BY '${WP_ADMIN_PASS}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${WP_ADMIN_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

# Run bootstrap SQL once
mysqld --user=mysql --datadir="$DB_INSTALL" --bootstrap < /tmp/init.sql
rm -f /tmp/init.sql

# Start MariaDB safely in the foreground
exec mysqld_safe --datadir="$DB_INSTALL"
