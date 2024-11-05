FROM ruby:3.3.0-slim

ARG APP_BASE

RUN apt-get update && apt-get install -y build-essential bash ca-certificates tzdata libpq-dev git cmake protobuf-compiler \
    && mkdir -p /srv/app \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/app
COPY "./$APP_BASE" /srv/app


RUN  gem install bundler \
    && bundle config set force_ruby_platform true \
    && bundle config build.grpc "--with-cflags=-Wno-error=incompatible-function-pointer-types" \
    && bundle install --jobs=8