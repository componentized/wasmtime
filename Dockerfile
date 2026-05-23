ARG rust=latest
FROM rust:${rust} AS build
RUN apt-get update && apt-get install gcc-$(arch | tr _ -)-linux-gnu musl-tools -y
RUN rustup target add $(arch)-unknown-linux-musl
ARG wasmtime
ARG wasmtime_source=crate
RUN \
  if [ "${wasmtime_source}" = "crate" ] ; then \
    cargo install \
      --target "$(arch)-unknown-linux-musl" \
      "wasmtime-cli${wasmtime:+@${wasmtime}}" \
      ; \
  elif [ "${wasmtime_source}" = "git" ] ; then \
    cargo install \
      --target "$(arch)-unknown-linux-musl" \
      --git https://github.com/bytecodealliance/wasmtime.git \
      --rev "${wasmtime}" \
      wasmtime-cli \
      ; \
  else \
    echo "Unknown wasmtime_source='${wasmtime_source}': expected 'crate' or 'git'" ; \
    exit 1 ; \
  fi
FROM cgr.dev/chainguard/static:latest
COPY --from=build /usr/local/cargo/bin/wasmtime /usr/bin/wasmtime
CMD ["/usr/bin/wasmtime"]
