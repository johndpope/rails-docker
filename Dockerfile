FROM ruby:2.2.2

# nodejs: taken from https://github.com/docker-library/rails/blob/master/Dockerfile
# mysql: same as above (for rake dbconsole)
# imagemagick: for RMagick
# zlib1g-dev: for nokogiri
RUN apt-get update && apt-get install -y \
    nodejs \
    mysql-client postgresql-client sqlite3 \
    imagemagick \
    zlib1g-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME
RUN bundle install

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
