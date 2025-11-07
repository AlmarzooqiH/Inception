FROM debian:11-slim

#continue setup ya ana

RUN apt update -y && apt upgrade -y && \
    apt install mariadb-server -y && \
    apt autoclean -y && \
    apt autoremove -y


EXPOSE 3306

CMD ["mariadbd"]
