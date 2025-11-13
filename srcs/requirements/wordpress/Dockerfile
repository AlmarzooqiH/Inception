FROM debian:11-slim


RUN apt update -y && apt upgrade -y && \
    apt install wget -y && \ 
    apt autoclean -y && \
    apt autoremove -y

COPY init/init.sh .

RUN chmod +x init.sh

RUN bash init.sh && rm -rf init.sh latest.tar.gz

EXPOSE 80

# Will change this comand later on, i kept it like this so i can keep the container running for testing.
CMD ["tail", "-f", "/dev/null"]
