FROM ruby:3.1.2-alpine@sha256:a8a62846da57d9f5b750204c45eb133ab1e18e66a4c98ad9a0bb66b5b615082f

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
