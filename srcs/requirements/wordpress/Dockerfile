FROM debian:bookworm

RUN apt update -y \
    && apt install -y \
        php8.2-fpm php8.2-mysql wget \
        mariadb-client nano tree \
        htop iputils-ping \
    && apt autoremove -y \
    && apt autoclean -y

USER root

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz && chown -R www-data:www-data /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm8.2", "-F"]
