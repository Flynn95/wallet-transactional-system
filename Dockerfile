FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y
RUN apt-get install yarn -y

ADD . /usr/src/app
WORKDIR /usr/src/app

RUN gem install bundler:'~> 2.1.4'

RUN bundle

RUN yarn install
RUN rails webpacker:install

CMD rails s -b 0.0.0.0
