
FROM ghcr.io/graalvm/graalvm-ce:ol7-java11
ARG VERSION="dev"

RUN adduser --home /opt/sur sur && \
    chown sur:sur /opt/sur

USER sur
WORKDIR /opt/sur

COPY --chown=besu:besu besu /opt/sur/

# Expose services ports
# 8545 HTTP JSON-RPC
# 8546 WS JSON-RPC
# 8547 HTTP GraphQL
# 30303 P2P
EXPOSE 8545 8546 8547 30303

# defaults for host interfaces
ENV BESU_RPC_HTTP_HOST 0.0.0.0
ENV BESU_RPC_WS_HOST 0.0.0.0
ENV BESU_GRAPHQL_HTTP_HOST 0.0.0.0
ENV BESU_PID_PATH "/tmp/pid"

ENV OTEL_RESOURCE_ATTRIBUTES="service.name=sur,service.version=$VERSION"

ENV OLDPATH="${PATH}"
ENV PATH="/opt/sur/bin:${OLDPATH}"

ENTRYPOINT ["sur"]
HEALTHCHECK --start-period=5s --interval=5s --timeout=1s --retries=10 CMD bash -c "[ -f /tmp/pid ]"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Sur EVMTool" \
      org.label-schema.description="Enterprise Ethereum client" \
      org.label-schema.url="https://surnet.org/" \
#      org.label-schema.vcs-ref=$VCS_REF \
#      org.label-schema.vcs-url="https://github.com/hyperledger/besu.git" \
      org.label-schema.vendor="Surnet" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
