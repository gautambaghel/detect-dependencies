FROM maven:3.3.9-jdk-8

# Git
RUN apt-get update && apt-get install -y git

# Golang
RUN \
    apt-get -y update \
    && apt-get -y install less gdb golang-1.10 \
    && apt-get clean

ENV PATH=/usr/lib/go-1.10/bin:$PATH

# Node
RUN apt-get -y install npm nodejs \
    && npm install -g yarn

# JAVA
RUN apt-get update && \
    apt-get -y install openjdk-8-jdk

# Download and install Gradle
RUN apt-get install -y curl wget unzip \
    && cd /usr/local \
    && curl -L https://services.gradle.org/distributions/gradle-2.5-bin.zip -o gradle-2.5-bin.zip \
    && unzip gradle-2.5-bin.zip \
    && rm gradle-2.5-bin.zip

# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-2.5 PATH=$PATH:$GRADLE_HOME/bin JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Clang
RUN apt-get install -y clang

# CPAN
RUN apt-get install -qy perl cpanminus \
    && rm -rf "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" \
    && cpanm Proc::ProcessTable Data::Dumper

# remove download archive files
RUN apt-get clean

CMD [ "/bin/sh" ]
