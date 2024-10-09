# syntax = docker/dockerfile:1

ARG NODE_IMAGE=node:lts-alpine3.20
# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2 
ARG RUBY_IMAGE=registry.docker.com/library/ruby:$RUBY_VERSION-slim
ARG USER=skrt
ARG UID=1000
ARG GID=${UID}
ARG HOME=/home/${USER}
ARG BUNDLE_PATH=/usr/local/bundle

# --- NODE IMAGE --- #
FROM ${NODE_IMAGE} AS node

# --- RUBY IMAGE --- #
FROM ${RUBY_IMAGE} AS base

ARG USER
ARG UID
ARG GID
ARG HOME
ARG BUNDLE_PATH

ENV BUNDLE_PATH=${BUNDLE_PATH}

# Create ${USER} User
RUN addgroup --gid ${GID} ${USER} && \
    adduser --system -u ${UID} --group ${USER} && \
    mkdir -p ${HOME} && chown -R ${USER}:${USER} ${HOME} && \
    mkdir -p ${BUNDLE_PATH} && chown -R ${USER}:${USER} ${BUNDLE_PATH}

# Install packages needed to build gems
RUN apt-get update -qq && \
apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config

COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

USER ${USER}
WORKDIR ${HOME}

# Set development environment
ENV RAILS_ENV="development" \
    # BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" 
    
# Throw-away build stage to reduce size of final image
FROM base AS builder-base

ARG USER
ARG UID
ARG GID
ARG HOME

USER root

RUN apt update && apt-get install -y npm
RUN npm install --global yarn

USER ${USER}

# --- NODEJS BUILDER --- #
FROM builder-base AS builder-node

COPY --chown=${UID}:${GID} package.json yarn.lock .yarnrc.yml ./
COPY --chown=${UID}:${GID} .yarn .yarn

RUN yarn set version berry

RUN yarn install

# --- RUBY BUILDER --- #

FROM builder-base AS ruby-builder

COPY --chown=${UID}:${GID} Gemfile Gemfile.lock tsconfig* vite.config.ts ./

RUN bundle install

COPY --from=builder-node --chown=${UID}:${GID} ${HOME}/node_modules ${HOME}/node_modules

COPY --chown=${UID}:${GID} . .

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
  bundle exec rake assets:precompile

# The following is a workaround to prevent node modules and .cache from being copied over to the runtime container.
# According to this issue, Docker does not provide a method to skip files while copying:
# https://github.com/moby/buildkit/issues/2853
RUN rm -rf node_modules .cache

# --- RUNTIME IMAGE --- #

FROM base AS runner

ARG BUNDLE_PATH
ARG HOME

ENV RAILS_LOG_TO_STDOUT=1

COPY --from=ruby-builder ${BUNDLE_PATH} ${BUNDLE_PATH}
COPY --from=ruby-builder ${HOME} ${HOME}

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
