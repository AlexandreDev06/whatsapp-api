# imagem base
FROM ruby:3.2.1-buster

# Install dependencies
RUN apt-get update && apt-get install -y build-essential autoconf \
bison libssl-dev libyaml-dev libreadline-dev lsb-release \
zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev \
libpq-dev curl ruby-full

# Install Redis
RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list
RUN apt-get update && apt-get install -y redis

# create directory for the app
RUN mkdir /recdin-whatsapp-api

# Set working directory
WORKDIR /recdin-whatsapp-api

# Add and install Gemfile
ADD Gemfile /recdin-whatsapp-api/Gemfile
ADD Gemfile.lock /recdin-whatsapp-api/Gemfile.lock

# Install gems
RUN bundle install

# Add the rails app inside the container
ADD . /recdin-whatsapp-api
