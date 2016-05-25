FROM ubuntu:14.04
MAINTAINER Eric

# Install dependencies
RUN dpkg --add-architecture i386                                    && \
    apt-get update                                                  && \
    apt-get install -y wget                                         && \
    apt-get install -y libncurses5:i386 libstdc++6:i386 zlib1g:i386 && \
    apt-get clean

# Install Java 7
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz && \
    tar -xzf jdk-7u79-linux-x64.tar.gz -C /usr/local && \
    rm jdk-7u79-linux-x64.tar.gz

# Install Java 8
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.tar.gz && \
    tar -xzf jdk-8u77-linux-x64.tar.gz -C /usr/local && \
    rm jdk-8u77-linux-x64.tar.gz

# 配置 Java 环境变量
ENV JAVA7_HOME /usr/local/jdk1.7.0_79
ENV JAVA8_HOME /usr/local/jdk1.8.0_77
ENV JAVA_HOME /usr/local/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin

# Install Android SDK
RUN wget -q http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
    tar -xzf android-sdk_r24.4.1-linux.tgz -C /usr/local              && \
    rm android-sdk_r24.4.1-linux.tgz

# 配置 Android SDK 环境变量
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/23.0.2

RUN echo yes | android update sdk --no-ui --all --filter platform-tools             && \
    echo yes | android update sdk --no-ui --all --filter build-tools-23.0.2         && \
    echo yes | android update sdk --no-ui --all --filter android-23                 && \
    echo yes | android update sdk --no-ui --all --filter android-22                 && \
    echo yes | android update sdk --no-ui --all --filter extra-android-m2repository && \
    echo yes | android update sdk --no-ui --all --filter extra-google-m2repository  && \
    echo yes | android update sdk --no-ui --all --filter extra-android-support