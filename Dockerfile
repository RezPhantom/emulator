FROM alvrme/alpine-android-base

ENV BUILD_TOOLS "28.0.3"
ENV TARGET_SDK "28"

RUN ${ANDROID_HOME}/tools/bin/sdkmanager "build-tools;${BUILD_TOOLS}" "platforms;android-${TARGET_SDK}"
RUN ${ANDROID_HOME}/tools/bin/sdkmanager "system-images;android-23;default;x86"
RUN echo no | ${ANDROID_HOME}/tools/bin/avdmanager create avd -n test -k "system-images;android-23;default;x86"
RUN ${ANDROID_HOME}/tools/bin/avdmanager list avd

RUN apk add qemu-system-i386
RUN mkdir -p /opt/sdk/tools/qemu/linux-x86_64
RUN mv /usr/bin/qemu-system-i386 /opt/sdk/tools/qemu/linux-x86_64/qemu-system-i386
RUN mkdir -p /opt/sdk/tools/lib64/qt/lib 
RUN cp /opt/sdk/tools/qemu/linux-x86_64/qemu-system-i386 /opt/sdk/tools/lib64/qt/lib/qemu-system-i386

#RUN ${ANDROID_HOME}/tools/emulator -avd test