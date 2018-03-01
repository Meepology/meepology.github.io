FROM ruby:2.5

WORKDIR /tmp
ADD Gemfile Gemfile
RUN bundle install

WORKDIR /site
