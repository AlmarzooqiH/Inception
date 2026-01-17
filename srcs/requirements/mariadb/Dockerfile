FROM debian:bookworm

# The user is root by defualt but i wanna be a bit more explicit :P
USER root

# Installing mandatory packages to make MariaDB able to work as well as some extra utilities such as nano. =D
RUN apt update -y && apt upgrade -y \
    && apt install -y mariadb-server mariadb-client nano tree htop \
    && apt autoremove -y && apt autoclean -y

# Changing the working direcrtory to whatever i put there LOL xD
WORKDIR /hamalmar-init

# Copying everything from the host machine current directory to the container current directory which in the case is hamalmar-init
COPY . .

# This is for docummentation purpoeses. I expose it on port 3306 with respect to the subject file
EXPOSE 3306

RUN chmod +x ./conf/hamalmar_mariadb_init.sh

# Using the entry point to my initalization script.
ENTRYPOINT ["./conf/hamalmar_mariadb_init.sh"]
