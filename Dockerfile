# 使いたいバージョンを決めて{{}}をruby:tag名の形で置き換えてください
# 例: ARG RUBY_VERSION=ruby:3.2.2
ARG RUBY_VERSION=ruby:3.2.2
# {{}}を丸ごと使いたいnodeのversionに置き換えてください、小数点以下はいれないでください
# 例: ARG NODE_VERSION=19
ARG NODE_VERSION=19

FROM --platform=linux/amd64 $RUBY_VERSION
ENV RAILS_ENV=production
ARG RUBY_VERSION
ARG NODE_VERSION
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential libpq-dev nodejs yarn vim cron

RUN apt-get update \
&& apt-get install -y chromium

RUN CHROMEDRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE) \
&& wget -N http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip -P ~/ \
&& unzip ~/chromedriver_linux64.zip -d ~/ \
&& mv ~/chromedriver /usr/local/bin/ \
&& rm ~/chromedriver_linux64.zip

RUN mkdir /app
WORKDIR /app
RUN gem install bundler
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY yarn.lock /app/yarn.lock
RUN bundle install
RUN yarn install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
