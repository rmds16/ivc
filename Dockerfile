FROM ubuntu:16.04

WORKDIR /code
RUN apt-get update
RUN apt-get install -y dnsutils curl wget libcurl4-openssl-dev libmysqlclient-dev git vim libxml2 libxml2-dev libxslt1-dev ruby-dev g++ libsasl2-dev build-essential uuid-dev whois libfontconfig1 libgmp-dev libpcre3-dev telnet ruby-railties bundler libssl-dev libxrender1 qtchooser qt5-default libqt5webkit5-dev libsqlite3-dev libpq-dev

ADD . /code

ENV RAILS_ENV=production
