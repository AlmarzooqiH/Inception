FROM debian:bookworm

RUN apt update -y && apt full-upgrade -y \
    && apt install -y tree htop \
    && apt autoremove -y && apt autoclean -y

USER root

WORKDIR /wordpress_init

COPY . .

EXPOSE 9000

RUN chmod +x ./tools/hamalmar_wordpress_init.sh

ENTRYPOINT ["./tools/hamalmar_wordpress_init.sh"]