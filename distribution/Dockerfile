FROM debian:bullseye-slim

RUN \
  apt-get update && \
  apt-get -y install ca-certificates && \
  apt-get clean

RUN groupadd -r khulnasoft && useradd --no-log-init -m -r -g khulnasoft khulnasoft

COPY khulnasoft /usr/bin/khulnasoft

USER khulnasoft

EXPOSE 8080

ENTRYPOINT ["khulnasoft"]
CMD ["--no-renderer-sandbox", "--listen", "0.0.0.0:8080"]
