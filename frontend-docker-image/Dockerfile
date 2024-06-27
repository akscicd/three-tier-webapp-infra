FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install curl -y

ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 16 && \
    nvm use 16

RUN ln -s /root/.nvm/versions/node/v16.20.2/bin/node /usr/local/bin/node

ENV PATH="/usr/local/bin:${PATH}"

ADD https://github.com/akscicd/three-tier-webapp.git /root/three-tier-webapp

WORKDIR /root/three-tier-webapp/application-code/web-tier

RUN . $NVM_DIR/nvm.sh && \
    nvm use 16 && \
    npm install && \
    npm run build

RUN apt-get install nginx -y

WORKDIR /etc/nginx
RUN rm nginx.conf
WORKDIR /root/three-tier-webapp/application-code
RUN cp nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]