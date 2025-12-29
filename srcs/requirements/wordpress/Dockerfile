FROM debian:bookworm

RUN apt update -y\
   && apt install -y php-fpm php-mysql wget nano tree htop \
   && apt autoremove -y && apt autoclean -y

USER root

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz && chown -R www-data:www-data /var/www/html



EXPOSE 9000

ENTRYPOINT ["/usr/sbin/php-fpm8.2", "-F"]
