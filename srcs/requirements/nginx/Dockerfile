FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt autoremove && apt autoclean

USER root

EXPOSE 443

COPY . .

RUN chmod +x ./hamalmar_nginx_init.sh

ENTRYPOINT [ "./hamalmar_nginx_init.sh" ]
