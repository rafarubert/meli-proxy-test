FROM ruby:3.0.2-alpine

ARG USER
ARG UID

RUN test -n "$USER"
RUN test -n "$UID"

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --no-create-home \
    --uid "$UID" \
    "$USER"

RUN apk add alpine-sdk git ruby-full ruby-dev

WORKDIR /app

COPY --chown=${USER} Gemfile /app/Gemfile
COPY --chown=${USER} *Gemfile.lock /app/

RUN chown -R $USER /app && mkdir /gems && \
    mkdir /mongo && chown -R $USER /gems /mongo 

ENV BUNDLE_PATH="/gems"

RUN gem install bundler && bundle install

COPY --chown=${USER} . /app
RUN chown -R $USER /app

USER "$USER"
