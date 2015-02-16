FROM ruby:2.2.0

ENV BUNDLE_APP_CONFIG /app/.bundle
ENV BUNDLE_PATH /app/vendor/bundler
ENV BUNDLE_DISABLE_SHARED_GEMS 1
ENV BUNDLE_JOBS 8
ENV BUNDLE_RETRY 3
ENV BUNDLE_BUILD__NOKOGIRI --use-native-libraries

RUN apt-get update \
 && apt-get install -y nodejs

WORKDIR /app

ADD . /app

RUN bundle install

ENTRYPOINT ["/app/script/docker-wrapper"]
CMD ["bin/rails", "s"]
