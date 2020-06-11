FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server unzip
RUN mkdir /var/run/sshd

ARG AUTHTOKEN
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok-stable-linux-amd64.zip
RUN ./ngrok authtoken ${AUTHTOKEN}

ARG PASSWORD


RUN echo 'root:'${PASSWORD} | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN echo '/usr/sbin/sshd && ./ngrok tcp 22 --log=stdout' > start.sh
run chmod +x start.sh
RUN set -x

run echo 'web_addr: 0.0.0.0:4040' >>  /root/.ngrok2/ngrok.yml

CMD ["sh", "./start.sh"]
