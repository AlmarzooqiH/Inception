#!/usr/bin/env bash
set -e

echo "Waiting for MariaDB to be ready ..."
until mariadb -h "${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" "${DATABASE}" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "MariaDB is unavailable - sleeping..."
    sleep 3
done
echo "MariaDB is up - continuing ..."

# Ensure WordPress directory exists
mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html
cd /var/www/html


# Download WordPress core if missing
if [ ! -f "index.php" ]; then
    echo "Downloading WordPress core..."
    wp core download --allow-root --force
fi

# Create wp-config.php if missing
if [ ! -f "wp-config.php" ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --allow-root \
        --dbname="${DATABASE}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --dbprefix="wp_"
fi

# Install WordPress if not installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="Incepting" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    echo "Creating WordPress user..."
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role="author" \
        --allow-root

    echo "WordPress installation complete."
else
    echo "WordPress is already installed."
fi

# Start PHP-FPM in foreground
exec php-fpm8.2 -F
