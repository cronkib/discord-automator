FROM ruby:3.0.0-buster AS ruby-env
RUN gem update --system && gem install bundler

FROM ruby-env as system-env
RUN apt update

FROM system-env as dbot-env
LABEL name="dbot"

ARG project_dir=/data/dbot
RUN mkdir -p $project_dir

COPY ./src $project_dir/src/
COPY ./dbot.rb $project_dir/
COPY ./Gemfile $project_dir/

WORKDIR $project_dir
RUN bundle install