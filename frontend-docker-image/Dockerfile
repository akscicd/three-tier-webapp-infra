FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install curl git -y

ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 16 && \
    nvm use 16

RUN ln -s /root/.nvm/versions/node/v16.20.2/bin/node /usr/local/bin/node

ENV PATH="/usr/local/bin:${PATH}"

WORKDIR /root/
RUN git clone https://github.com/akscicd/three-tier-webapp.git
RUN rm -rf /root/three-tier-webapp/application-code/nginx.conf
RUN mv /root/three-tier-webapp/build/application-code/nginx.conf /root/three-tier-webapp/application-code/

WORKDIR /root/three-tier-webapp-infra/application-code/web-tier

RUN . $NVM_DIR/nvm.sh && \
    nvm use 16 && \
    npm install && \
    npm run build

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq nginx

WORKDIR /etc/nginx
RUN rm nginx.conf
WORKDIR /root/three-tier-webapp/application-code
RUN cp nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]
