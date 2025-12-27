FROM debian:bookworm

RUN apt update -y && apt full-upgrade -y \
    && apt install -y mariadb-server mariadb-client tree htop \
    && apt autoremove -y && apt autoclean -y

USER root

WORKDIR /hamalmar-init

COPY . .

EXPOSE 3306

RUN chmod +x ./conf/hamalmar_mariadb_init.sh
# RUN tail -f

ENTRYPOINT ["./conf/hamalmar_mariadb_init.sh"]
