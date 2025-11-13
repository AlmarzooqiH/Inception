FROM debian:11-slim

#continue setup ya ana

RUN apt update -y && apt upgrade -y && \
    apt install mariadb-server -y && \
    apt autoclean -y && \
    apt autoremove -y

COPY ./setup/hamalmar_mariadb_init.sh /usr/local/bin

RUN chmod +x /usr/local/bin/hamalmar_mariadb_init.sh

EXPOSE 3306

CMD ["/usr/local/bin/hamalmar_mariadb_init.sh"]
