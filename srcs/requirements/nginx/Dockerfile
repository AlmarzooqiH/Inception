FROM debian:11-slim

RUN apt update -y && apt upgrade -y && \
    apt install nginx -y && \
    apt autoclean -y && \
    apt autoremove -y

COPY conf/ssl/ /etc/nginx/ssl/

RUN chmod 777 /etc/nginx/ssl/nginx.crt /etc/nginx/ssl/nginx.key

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
