FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
        && apk --no-cache add ca-certificates \
        && apk --no-cache add curl \
        && apk --no-cache add tzdata \
        && cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime \
        && echo "Asia/Hong_Kong" > /etc/timezone \
        && apk --no-cache del tzdata \
        && cd /etc/apk/keys \
        && curl -LO https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
        && mkdir -p /opt/java \
        && cd /opt/java \
        && curl -LO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk \
        && apk --no-cache add glibc-2.34-r0.apk \
        && curl -LO https://$your_jdk_mirror/oracle_jdk/jdk8/server-jre-8u301-linux-x64.tar.gz \
        && tar xf server-jre-8u301-linux-x64.tar.gz \
        && rm -rf server-jre-8u301-linux-x64.tar.gz glibc-2.34-r0.apk \
        && rm -rf /var/cache/apk/*

ENV JAVA_HOME /opt/java/jdk1.8.0_301
ENV CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $JAVA_HOME/bin:$PATH

WORKDIR /opt/java/jdk1.8.0_301

CMD ["java", "-version"]
