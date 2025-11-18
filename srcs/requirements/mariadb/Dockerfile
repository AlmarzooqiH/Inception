FROM debian:bookworm

RUN apt update -y && apt full-upgrade -y && \
    apt install -y mariadb-server mariadb-client && \
    apt autoclean -y && apt autoremove -y

USER root

COPY ./conf/hamalmar_mariadb_init.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/hamalmar_mariadb_init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/hamalmar_mariadb_init.sh"]
