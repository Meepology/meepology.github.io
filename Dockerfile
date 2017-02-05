FROM ruby:2.3.3

WORKDIR /tmp
ADD Gemfile Gemfile
RUN bundle install

WORKDIR /site
