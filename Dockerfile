FROM openjdk:8u151-jdk
MAINTAINER Christian Hoffmeister <chrishoff@welevel.com>

ENV SCALA_VERSION="2.12.4"
ENV SBT_VERSION="0.13.15"
ENV DOCKER_VERSION="17.12.1-ce"

WORKDIR /tmp
RUN \
  wget -q http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz && \
  echo "b5bb5555f8106e08b5344127179a11e51b632135  scala-$SCALA_VERSION.tgz" | shasum -c - && \
  tar xf scala-$SCALA_VERSION.tgz && \
  mv scala-$SCALA_VERSION /opt/scala && \
  ln -s /opt/scala/bin/fsc /usr/bin/fsc && \
  ln -s /opt/scala/bin/scala /usr/bin/scala && \
  ln -s /opt/scala/bin/scalac /usr/bin/scalac && \
  ln -s /opt/scala/bin/scaladoc /usr/bin/scaladoc && \
  ln -s /opt/scala/bin/scalap /usr/bin/scalap && \
  rm scala-$SCALA_VERSION.tgz
RUN \
  wget -q https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
  echo "46f07dbfec874be8687072e07d2c3f22b4f7cc76  sbt-$SBT_VERSION.tgz" | shasum -c - && \
  tar xf sbt-$SBT_VERSION.tgz && \
  mv sbt /opt/sbt && \
  ln -s /opt/sbt/bin/sbt /usr/bin/sbt && \
  rm sbt-$SBT_VERSION.tgz && \
  mkdir project && \
  echo "sbt.version=0.13.12" > project/build.properties && \
  sbt sbtVersion && \
  echo "sbt.version=0.13.13" > project/build.properties && \
  sbt sbtVersion && \
  echo "sbt.version=0.13.14" > project/build.properties && \
  sbt sbtVersion && \
  echo "sbt.version=0.13.15" > project/build.properties && \
  sbt sbtVersion && \
  echo "sbt.version=0.13.16" > project/build.properties && \
  sbt sbtVersion && \
  rm -rf project
RUN \
  wget -q https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
  echo "9dd0d19312640460671352930eb44b1692441d95  docker-$DOCKER_VERSION.tgz" | shasum -c - && \
  tar xf docker-$DOCKER_VERSION.tgz && \
  mv docker /opt/docker && \
  ln -s /opt/docker/docker /usr/bin/docker && \
  rm -r docker-$DOCKER_VERSION.tgz

WORKDIR /root