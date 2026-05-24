ARG rust_version
FROM rust:${rust_version} AS build
RUN apt-get update && apt-get install gcc-$(arch | tr _ -)-linux-gnu musl-tools -y
RUN rustup target add $(arch)-unknown-linux-musl
ARG wasmtime_revision
ARG wasmtime_version
ARG wasmtime_commit_date
RUN \
  cargo install \
    --target "$(arch)-unknown-linux-musl" \
    --git https://github.com/bytecodealliance/wasmtime.git \
    --rev "${wasmtime_revision}" \
    wasmtime-cli
ARG base
ARG base_digest
FROM ${base}@${base_digest}
COPY --from=build --timestamp="${wasmtime_commit_date}" \
  /usr/local/cargo/bin/wasmtime \
  /usr/bin/wasmtime
ENTRYPOINT ["wasmtime"]
CMD ["--version"]
LABEL org.opencontainers.image.created="${wasmtime_commit_date}"
LABEL org.opencontainers.image.authors="Bytecode Alliance <https://bytecodealliance.org>"
LABEL org.opencontainers.image.source="https://github.com/bytecodealliance/wasmtime"
LABEL org.opencontainers.image.version="${wasmtime_version}"
LABEL org.opencontainers.image.revision="${wasmtime_revision}"
LABEL org.opencontainers.image.vendor="Componentized <https://github.com/componentized>"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.base.digest="${base_digest}"
LABEL org.opencontainers.image.base.name="${base}"
