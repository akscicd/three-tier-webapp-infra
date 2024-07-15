FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl git gnupg mysql-client-core-8.0


ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 16 && \
    nvm use 16 && \
    npm install -g pm2


RUN ln -s /root/.nvm/versions/node/v16.20.2/bin/node /usr/local/bin/node


ENV PATH="/usr/local/bin:${PATH}"

WORKDIR /root/
RUN git clone https://github.com/akscicd/three-tier-webapp.git
RUN rm -rf /root/three-tier-webapp/application-code/app-tier/DbConfig.js
RUN mv /root/three-tier-webapp/build/application-code/app-tier/DbConfig.js /root/three-tier-webapp/application-code/app-tier
WORKDIR /root/three-tier-webapp/application-code/app-tier


RUN . $NVM_DIR/nvm.sh && \
    nvm use 16 && \
    npm install && \
    pm2 start index.js && \
    pm2 startup && \
    pm2 save


EXPOSE 4000


CMD ["/root/.nvm/versions/node/v16.20.2/bin/pm2-runtime", "start", "index.js"]
