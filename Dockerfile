
FROM ubuntu:20.04
ARG VERSION="dev"

RUN apt-get update && \
 apt-get install --no-install-recommends -q --assume-yes openjdk-17-jre-headless=17* && \
 apt-get clean  && \
 rm -rf /var/lib/apt/lists/*  && \
 adduser --disabled-password --gecos "" --home /opt/sur sur && \
    chown sur:sur /opt/sur

USER sur
WORKDIR /opt/sur

COPY --chown=sur:sur build /opt/sur/

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
ENV BESU_RPC_HTTP_ENABLED=true
ENV BESU_RPC_HTTP_API=ETH,NET,IBFT
ENV BESU_HOST_ALLOWLIST=*
ENV BESU_RPC_HTTP_CORS_ORIGINS=all
ENV BESU_FAST_SYNC_MIN_PEERS=1
ENV BESU_MIN_GAS_PRICE=10000000000000
ENV BESU_PID_PATH "/tmp/pid"
ENV BESU_GENESIS_FILE=/opt/sur/externalVolume/genesis.json
ENV BESU_DATA_PATH=/opt/sur/externalVolume/data

ENV OTEL_RESOURCE_ATTRIBUTES="service.name=sur,service.version=$VERSION"

ENV OLDPATH="${PATH}"
ENV PATH="/opt/sur/bin:${OLDPATH}"

ENTRYPOINT ["bin/besu"]
HEALTHCHECK --start-period=5s --interval=5s --timeout=1s --retries=10 CMD bash -c "[ -f /tmp/pid ]"

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Sur" \
      org.label-schema.description="Enterprise Ethereum client" \
      org.label-schema.url="https://besu.hyperledger.org/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Sur-network/Sur" \
      org.label-schema.vendor="Hyperledger" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.1"
