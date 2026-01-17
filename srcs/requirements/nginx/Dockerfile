FROM debian:bookworm

# The user is root by defualt but i wanna be a bit more explicit :P
USER root

# Installing mandatory packages to make nginx able to work as well as some extra utilities such as nano. =D
RUN apt update -y \
    && apt upgrade -y \
    && apt install -y tree nano htop curl gnupg2 ca-certificates lsb-release debian-archive-keyring \
    && apt autoremove -y && apt autoclean -y

# Installing nginx
RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    https://nginx.org/packages/debian `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

RUN apt -y update && apt install -y nginx

# I mean this is self explanitory LOL
COPY ./conf/cert.pem /etc/nginx/cert.pem
COPY ./conf/key.pem /etc/nginx/key.pem
COPY ./conf/hamalmar-nginx-init.sh /bin/
RUN chmod +x /bin/hamalmar-nginx-init.sh

# This is for docummentation purpoeses. I expose it on port 443 with respect to the subject file
EXPOSE 443

# Using the entry point to my initalization script.
ENTRYPOINT ["/bin/hamalmar-nginx-init.sh"]
