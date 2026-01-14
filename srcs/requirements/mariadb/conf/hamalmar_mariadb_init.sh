#!/usr/bin/env bash
set -e

# Ensure runtime and data directories exist
mkdir -p /run/mysqld
mkdir -p /var/lib/mysql
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Ensure MariaDB listens on all interfaces (for Docker network)
if grep -q "127.0.0.1" /etc/mysql/mariadb.conf.d/50-server.cnf; then
    sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
fi

# Initialize system database if missing
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB system tables..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --rpm
fi

# Run database/user creation ONLY once
if [ ! -d "/var/lib/mysql/${WORDPRESS_DB_NAME}" ]; then
    echo "Setting up WordPress database and users..."

cat > /tmp/init.sql <<EOF
FLUSH PRIVILEGES;

-- Secure root account
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';

-- Cleanup default insecure settings
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;

-- Create WordPress database
CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB_NAME}\`
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Create admin-level WordPress DB user (username cannot contain 'admin')
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_ADMIN}'@'%' IDENTIFIED BY '${WORDPRESS_DB_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO '${WORDPRESS_DB_ADMIN}'@'%';

-- Create standard WordPress DB user
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO '${WORDPRESS_DB_USER}'@'%';

FLUSH PRIVILEGES;

EOF

# Run the init SQL
mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap < /tmp/init.sql
rm -f /tmp/init.sql

fi

# Start MariaDB in foreground (PID 1)
exec mysqld_safe --datadir=/var/lib/mysql
