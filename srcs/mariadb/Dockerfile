FROM debian:11-slim

#continue setup ya ana

RUN apt update -y && apt upgrade -y && \
    apt install mariadb-server -y && \
    apt autoclean -y && \
    apt autoremove -y


ENV MARIADB_ROOT_PASSWORD=1234 \
    MARIADB_DATABASE=mydb \
    MARIADB_USER=hamalmar \
    MARIADB_PASSWORD=1234

EXPOSE 3306


CMD ["mariadbd"]
