FROM debian:bookworm

# The user is root by defualt but i wanna be a bit more explicit :P
USER root

# Installing mandatory packages to make wordpress able to work and connect to mariadb as well as some extra utilities such as nano. =D
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y curl mariadb-client sendmail php8.2 php8.2-fpm php8.2-mysql nano \
    && mkdir -p /run/php \
    && apt autoremove -y \
    && apt autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Installing wp-cli :D
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# I mean this is self explanitory LOL
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY ./conf/hamalmar-init-wordpress.sh /usr/local/bin/hamalmar-init-wordpress.sh
RUN chmod +x /usr/local/bin/hamalmar-init-wordpress.sh

# This is for docummentation purpoeses. I expose it on port 9000 with respect to the subject file
EXPOSE 9000

# Using the entry point to my initalization script.
ENTRYPOINT ["/usr/local/bin/hamalmar-init-wordpress.sh"]
