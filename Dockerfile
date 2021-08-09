FROM ruby:3.0.2

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY *Gemfile.lock /app/

RUN apt-get update -y\
    && apt-get install figlet toilet -y\
    && gem install bundler \
    && bundle install
