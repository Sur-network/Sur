
FROM openjdk:11.0.7-jre-slim-buster

RUN adduser --disabled-password --gecos "" --home /opt/sur-evmtool sur && \
    chown sur:sur /opt/sur-evmtool

USER sur
WORKDIR /opt/sur-evmtool

COPY --chown=sur:sur besu-evmtool /opt/sur-evmtool/

ENV PATH="/opt/sur-evmtool/bin:${PATH}"
ENTRYPOINT ["evm"]

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Sur EVMTool" \
      org.label-schema.description="EVM Execution Tool" \
      org.label-schema.url="https://surnet.org/" \
      org.label-schema.vendor="Surnet" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"