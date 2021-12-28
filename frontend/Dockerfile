FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y nodejs sudo npm yarn curl
RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

RUN useradd -rm -d /home/hosting -s /bin/bash -g root -G sudo -u 1001 hosting
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER hosting
WORKDIR /home/hosting/blog-front

RUN sudo npm install -g n
RUN sudo n latest
RUN sudo npm install -g npm
RUN /bin/bash -l -c "hash -d npm"
RUN sudo npm i -g @vue/cli
RUN npm install --save axios
RUN npm install --save @popperjs/core bootstrap
RUN npm install --save html2pdf.js

EXPOSE 8080

CMD ["/bin/bash", "sudo", "npm", "run", "serve"]