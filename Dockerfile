FROM ruby:3.3.5-alpine@sha256:0bf4169697f44df52cea27b0ceb1a3b715b168625b7c404202e2dfe31dee25e2

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      g++ \
      gcc \
      libstdc++ \
      libffi-dev \
      libc-dev \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      sqlite \
      sqlite-dev \
      # not needed for gems, but for runtime
      git \
      tzdata

# RUN gem install bundler -v 2.3.11

ENV APP_HOME /hdm
WORKDIR $APP_HOME

COPY . $APP_HOME
COPY config/hdm.yml.template $APP_HOME/config/hdm.yml

RUN bundle check || (bundle config set --local without 'test' && bundle install)

EXPOSE 3000

CMD ["/hdm/bin/entry.sh"]
