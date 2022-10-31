FROM ruby:3.1.2-alpine@sha256:a39e26d0598837f08c75a42c8b0886d9ed5cc862c4b535662922ee1d05272fca

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
