#!/bin/sh
set -e

# 1️⃣ Copy configs
mv ./conf/wp-config.php .
rm /etc/php/8.2/fpm/pool.d/www.conf
cp ./conf/www.conf /etc/php/8.2/fpm/pool.d/

# 2️⃣ Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysql -h "${MARIADB_HOST:-mariadb}" \
           -u"$WORDPRESS_DB_USER" \
           -p"$WORDPRESS_DB_PASSWORD" \
           -e "SELECT 1" &> /dev/null; do
  echo "MariaDB not ready, sleeping 2s..."
  sleep 2
done

echo "MariaDB is ready. Starting PHP-FPM..."

# 3️⃣ Start PHP-FPM
exec /usr/sbin/php-fpm8.2 -F
