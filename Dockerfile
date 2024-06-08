FROM ruby:3.0

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /usr/src/app

COPY Gemfile ./
RUN gem install bundler:2.5.11 && bundle install

EXPOSE 4000

