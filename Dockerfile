FROM ruby:2.7.2-alpine
WORKDIR /usr/src/app
RUN apk --no-cache add build-base tzdata postgresql-dev
COPY Gemfile Gemfile.lock ./
RUN gem update --system \
    && gem install bundler -v 2.0.2 \
    && gem install rails -v 6.0.3.2 \
    && bundle install
COPY . .
