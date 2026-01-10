FROM debian:bookworm

USER root

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y \
        php8.2-fpm php8.2-mysql php8.2-xml php8.2-curl php8.2-gd \
        php8.2-mbstring php8.2-zip php8.2-intl \
        mariadb-client wget \
    && apt autoremove -y \
    && apt autoclean -y



WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html

COPY . .

RUN cat ./conf/www.conf > /etc/php/8.2/fpm/pool.d/www.conf \
    && rm -rf ./conf/

EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm8.2", "-F"]
