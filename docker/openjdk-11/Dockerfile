
FROM openjdk:11.0.7-jre-slim-buster

RUN adduser --disabled-password --gecos "" --home /opt/sur sur && \
    chown sur:sur /opt/sur

USER sur
WORKDIR /opt/sur

COPY --chown=sur:sur sur /opt/sur/

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
# Tracing defaults
# To enable tracing, uncomment next line
#ENV TRACING=ENABLED
ENV OTEL_EXPORTER=otlp
ENV OTEL_OTLP_ENDPOINT="0.0.0.0:55680"
ENV OTEL_RESOURCE_ATTRIBUTES="service.name=sur-$VERSION"

ENV PATH="/opt/sur/bin:${PATH}"
ENTRYPOINT ["sur"]
HEALTHCHECK --start-period=5s --interval=5s --timeout=1s --retries=10 CMD bash -c "[ -f /tmp/pid ]"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Sur" \
      org.label-schema.description="EVM Execution Tool" \
      org.label-schema.url="https://surnet.org/" \
      org.label-schema.vendor="Surnet" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"