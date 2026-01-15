FROM debian:bookworm

USER root

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y curl mariadb-client sendmail php8.2 php8.2-fpm php8.2-mysql nano \
    && mkdir -p /run/php \
    && apt autoremove -y \
    && apt autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM config and WordPress init script
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY ./conf/hamalmar-init-wordpress.sh /usr/local/bin/hamalmar-init-wordpress.sh
RUN chmod +x /usr/local/bin/hamalmar-init-wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/hamalmar-init-wordpress.sh"]
