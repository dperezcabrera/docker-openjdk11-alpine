#! /bin/bash

set -o errexit

JDK_BUILD="27"
VERSION="ea-${JDK_BUILD}"
IMAGE="dperezcabrera/openjdk11-alpine"
JDK_ARCHIVE="openjdk-11+${JDK_BUILD}_linux-x64-musl_bin.tar.gz"
JDK_URL="https://download.java.net/java/early_access/alpine/${JDK_BUILD}/binaries/${JDK_ARCHIVE}"
JAVA_DOWNLOAD_HOME="jdk-11"

download_jdk() {

	echo "Downloading ${JDK_ARCHIVE}"
	wget ${JDK_URL}

	echo "Downloading sha256 checksum"
	wget ${JDK_URL}.sha256

	echo "Verify checksum"
	echo "  ${JDK_ARCHIVE}" >> ${JDK_ARCHIVE}.sha256
	sha256sum -c ${JDK_ARCHIVE}.sha256

	echo "Checksum is correct"

	echo "Extract JDK"
	tar -xzf ${JDK_ARCHIVE}
	# Remove downloaded files
	rm ${JDK_ARCHIVE} ${JDK_ARCHIVE}.sha256
	rm ${JAVA_DOWNLOAD_HOME}/lib/src.zip
}

delete_java_download() {
        if [ -d "$JAVA_DOWNLOAD_HOME" ]; then
                rm -rf "$JAVA_DOWNLOAD_HOME"
        fi
}

main () {
	delete_java_download
	download_jdk
	docker build -t ${IMAGE}:${VERSION} .
	docker build -t ${IMAGE} .
	delete_java_download
	docker run --rm ${IMAGE}:${VERSION} java -version
	docker push ${IMAGE}
	docker push ${IMAGE}:${VERSION}
}

# https://docs.oracle.com/javase/10/tools/jshell.htm
# https://en.wikipedia.org/wiki/JShell
# https://github.com/keckelt/openjdk11-alpine

main

