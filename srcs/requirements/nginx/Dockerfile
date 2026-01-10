FROM debian:bookworm

USER root

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y tree nano htop curl gnupg2 ca-certificates lsb-release debian-archive-keyring \
    && apt autoremove -y && apt autoclean -y

RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    https://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

RUN apt -y update && apt install -y nginx

# Copy only what we need
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/cert.pem /etc/nginx/cert.pem
COPY ./conf/key.pem /etc/nginx/key.pem

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
