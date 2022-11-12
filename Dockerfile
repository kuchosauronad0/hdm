FROM ruby:3.1.2-alpine@sha256:05b990dbaa3a118f96e9ddbf046f388b3c4953d5ef3d18908af96f42c0e138d9

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
