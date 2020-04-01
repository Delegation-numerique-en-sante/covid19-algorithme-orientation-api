FROM elixir:1.10.2-alpine AS build

# Set environment variables for building the application
ENV MIX_ENV=prod

# Install build dependencies
RUN apk add --update build-base gcc git && \
    rm -rf /var/cache/apk/*

# Install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# Install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, compile

# Build project
COPY lib lib
RUN mix compile

# Build release
COPY rel rel
RUN mix release

# Prepare release image
FROM alpine:3.9 AS app

# Install openssl
RUN apk add --update bash openssl && \
    rm -rf /var/cache/apk/*

# Copy over the build artifact from the previous step and create a non root user
RUN adduser -D -h /home/app app
WORKDIR /home/app

COPY --from=build /app/_build/prod/rel/covid19_questionnaire .
RUN chown -R app: .
USER app

ENV HOME=/home/app
