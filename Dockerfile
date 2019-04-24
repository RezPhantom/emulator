FROM ubuntu:16.04

ENV ANDROID_VERSION "23"
ENV ANDROID_HOME "/usr/lib/android-sdk"
#ENV ANDROID_SDK_ROOT "/root/.android/avd"
ENV ANDROID_AVD_HOME "/root/.android/avd"
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

RUN apt-get update \
    && apt-get -y install openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

RUN apt-get -y install mesa-utils
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y install kvm qemu-kvm libvirt-bin bridge-utils libguestfs-tools
RUN apt update && apt install wget
RUN apt install -y unzip
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

RUN unzip sdk-tools-linux-4333796.zip
RUN rm sdk-tools-linux-4333796.zip
RUN mkdir android-sdk
RUN mv tools android-sdk/tools

WORKDIR /usr/lib/android-sdk

RUN pwd
RUN yes | /android-sdk/tools/bin/sdkmanager --licenses 
RUN /android-sdk/tools/bin/sdkmanager --update
RUN /android-sdk/tools/bin/sdkmanager "system-images;android-23;default;x86"
RUN /android-sdk/tools/bin/sdkmanager "build-tools;23.0.0" "platforms;android-23" 
RUN /android-sdk/tools/bin/sdkmanager "platform-tools" 
RUN /android-sdk/tools/bin/sdkmanager "emulator"

RUN echo no | /android-sdk/tools/bin/avdmanager create avd -n darren -k "system-images;android-23;default;x86"
RUN /android-sdk/tools/emulator -list-avds