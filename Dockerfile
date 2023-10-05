FROM ruby:3.2.2

ARG GRAALVM_PATH=/opt/graalvm-jdk
ARG JAVA_VERSION=21

RUN set -eu && \
  apt-get update -y && \
  apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p ${GRAALVM_PATH} && \
  curl -L https://download.oracle.com/graalvm/${JAVA_VERSION}/latest/graalvm-jdk-${JAVA_VERSION}_linux-$(arch)_bin.tar.gz | \
  tar zx -C ${GRAALVM_PATH} --strip-components 1

WORKDIR /usr/src/gem

RUN set -eu \
  && mkdir -p lib/graal_ext_rb_example \
  && echo "module GraalExtRbExample\n  VERSION = \"0.1.0\"\nend\n" > lib/graal_ext_rb_example/version.rb

COPY bin/setup ./bin/
COPY Gemfile Gemfile.lock graal_ext_rb_example.gemspec ./

RUN set -eu \
  && bin/setup

ENV JAVA_HOME=$GRAALVM_PATH \
    PATH=$GRAALVM_PATH/bin:$PATH
