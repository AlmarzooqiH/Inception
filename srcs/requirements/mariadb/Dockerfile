FROM debian:bookworm

USER root

RUN apt update -y && apt upgrade -y \
    && apt install -y mariadb-server mariadb-client nano tree htop \
    && apt autoremove -y && apt autoclean -y

WORKDIR /hamalmar-init

COPY . .

EXPOSE 3306

RUN chmod +x ./conf/hamalmar_mariadb_init.sh

ENTRYPOINT ["./conf/hamalmar_mariadb_init.sh"]
