FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get install -y curl gnupg2 build-essential sudo
RUN apt-get install postgresql-contrib libpq-dev -y
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get install libfontconfig libxrender1 libjpeg-turbo8 wkhtmltopdf -y

RUN apt install npm -y 
RUN npm install yarn -g
RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

RUN useradd -rm -d /home/hosting -s /bin/bash -g root -G sudo -u 1001 hosting
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER hosting
WORKDIR /home/hosting/blog

RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -

#RUN /bin/bash -l -c "sudo chmod 777 /etc/resolv.conf"
#RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
#RUN gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN echo ""
RUN curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile"
RUN /bin/bash -l -c "echo 'source ~/.rvm/scripts/rvm' >> ~/.bashrc"
RUN /bin/bash -l -c "source ~/.bashrc"
RUN /bin/bash -l -c "rvm install "ruby-3.0.2""
RUN /bin/bash -l -c "rvm use 3.0.2"
RUN /bin/bash -l -c "gem install bundler"

COPY Gemfile /home/hosting/blog
COPY Gemfile.lock /home/hosting/blog
RUN /bin/bash -l -c "bundle install"
#RUN /bin/bash -l -c "rails webpacker:install"
#RUN chmod -R 777 /var/lib/gems/2.7.0/gems/wkhtmltopdf-binary-0.12.6.5/bin/
#RUN /bin/bash -l -c "rvm reset"

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]




