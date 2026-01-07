FROM debian:bookworm

USER root

RUN    apt update -y \
    && apt upgrade -y \
    && apt install -y tree nano htop curl gnupg2 ca-certificates lsb-release debian-archive-keyring \
    && apt autoremove && apt autoclean

RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
        https://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list

RUN apt -y update && apt install -y nginx

EXPOSE 443

COPY . .

RUN chmod +x ./conf/hamalmar_nginx_init.sh

ENTRYPOINT [ "./conf/hamalmar_nginx_init.sh" ]
