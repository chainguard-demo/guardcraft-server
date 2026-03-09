FROM cgr.dev/chainguard/jre:latest-dev@sha256:84a49d93aa250a4b29759c1690c00d0ac7c63504e32417f9d70e4853287558fd

ARG VERSION="latest"
USER root
RUN apk update && apk add curl libudev jq
RUN adduser --system minecraft
WORKDIR /usr/share/minecraft

COPY build-config.sh server-install.sh /usr/share/minecraft/
RUN chmod +x /usr/share/minecraft/build-config.sh /usr/share/minecraft/server-install.sh
RUN /usr/share/minecraft/server-install.sh ${VERSION}
RUN chown -R minecraft /usr/share/minecraft
USER minecraft

ENTRYPOINT ["/usr/share/minecraft/build-config.sh", "java", "-jar" , "/usr/share/minecraft/server.jar", "nogui"]
