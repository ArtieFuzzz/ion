FROM --platform=arm64 ruby:slim-buster

RUN apt-get update -y --no-install-recommends
RUN apt-get install --no-install-recommends -y \
  curl build-essential
  # && \
  # curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
  # curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  # echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  # apt-get install -y nodejs
RUN rm -rf /var/lib/apt/lists/*

# RUN npm i -g yarn

# RUN bundle config --global frozen 1
RUN bundle config set force_ruby_platform true

WORKDIR /railway

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

# CMD ["ruby","bin/rails", "server",  "-e", "production"]