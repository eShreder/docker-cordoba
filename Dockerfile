FROM openjdk

ENV NODE_VERSION 6.9.2
ENV NODE_PATH /usr

ENV ANDROID_HOME /opt/android-sdk-linux
ENV SDK_VERSION r24.4.1-linux
ENV ANDROID_PLATFORM android-23
ENV BUILD_TOOLS 25.0.2

ENV PATH ${PATH}:/opt/tools

RUN cd /opt && wget -q https://dl.google.com/android/android-sdk_${SDK_VERSION}.tgz -O android-sdk.tgz
RUN cd /opt && tar -xvzf android-sdk.tgz
RUN cd /opt && rm -f android-sdk.tgz

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN echo y | android update sdk --no-ui --all --filter platform-tools | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter ${ANDROID_PLATFORM} | grep 'package installed'

RUN echo y | android update sdk --no-ui --all --filter build-tools-${BUILD_TOOLS} | grep 'package installed'

RUN android update sdk --no-ui --obsolete --force

RUN wget https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz \
    && gunzip -d node-v${NODE_VERSION}-linux-x64.tar.gz \
    && tar xf node-v${NODE_VERSION}-linux-x64.tar \
    && cp -r node-v${NODE_VERSION}-linux-x64/bin/* $NODE_PATH/bin/ \
    && cp -r node-v${NODE_VERSION}-linux-x64/include/* $NODE_PATH/include/ \
    && cp -r node-v${NODE_VERSION}-linux-x64/lib/* $NODE_PATH/lib/ \
    && cp -r node-v${NODE_VERSION}-linux-x64/share/* $NODE_PATH/share/ \
    && rm -r node-v${NODE_VERSION}-linux-x64*

RUN npm install -g cordova

RUN chown -R 1000:1000 $ANDROID_HOME
VOLUME ["/opt/android-sdk-linux"]
