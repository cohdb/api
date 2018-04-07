FROM rust:1.24.1 as rust

# Install vault library
RUN mkdir -p /lib
WORKDIR /lib

ADD https://api.github.com/repos/ryantaylor/vault/git/refs/heads/master version.json
RUN git clone -bmaster https://github.com/ryantaylor/vault.git

WORKDIR /lib/vault
RUN cargo build --release --features ffi

FROM circleci/ruby:2.5-node
MAINTAINER ryan@ryantaylordev.ca

# Copy over vault library
RUN mkdir -p /lib
COPY --from=rust /lib /lib
