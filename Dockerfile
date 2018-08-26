FROM alpine:3.8
MAINTAINER David Perez Cabrera, dperezcabrera@gmail.com

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# There might be newer builds, but not all are published (for apline) at: http://jdk.java.net/11/

ENV JAVA_HOME="/jdk-11"

ADD .${JAVA_HOME} ${JAVA_HOME}

ENV PATH=$PATH:${JAVA_HOME}/bin

# https://docs.oracle.com/javase/10/tools/jshell.htm
# https://en.wikipedia.org/wiki/JShell
# https://github.com/keckelt/openjdk11-alpine
CMD ["jshell"]
