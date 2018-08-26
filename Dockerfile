FROM alpine:3.8
MAINTAINER David Perez Cabrera, dperezcabrera@gmail.com

ENV LANG C.UTF-8
ENV JAVA_HOME="/jdk-11"

ADD .${JAVA_HOME} ${JAVA_HOME}
ENV PATH=$PATH:${JAVA_HOME}/bin

# https://docs.oracle.com/javase/10/tools/jshell.htm
# https://en.wikipedia.org/wiki/JShell
# https://github.com/keckelt/openjdk11-alpine
CMD ["jshell"]
