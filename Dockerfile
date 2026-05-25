ARG from_build from_base
FROM ${from_build} AS build
ARG wasmtime_crate wasmtime_git_rev
RUN \
  apt-get update ; \
  apt-get install gcc-$(arch | tr _ -)-linux-gnu musl-tools -y ; \
  rustup target add $(arch)-unknown-linux-musl ; \
  if [ "${wasmtime_crate}" = "" ] ; then \
    cargo install \
      --target "$(arch)-unknown-linux-musl" \
      --git https://github.com/bytecodealliance/wasmtime.git \
      --rev "${wasmtime_git_rev}" \
      --locked \
      wasmtime-cli \
    ; \
  else \
    cargo install \
      --target "$(arch)-unknown-linux-musl" \
      --locked \
      wasmtime-cli@${wasmtime_crate} \
    ; \
  fi
FROM "${from_base}"
COPY --from=build \
  /usr/local/cargo/bin/wasmtime \
  /usr/bin/wasmtime
ENTRYPOINT ["wasmtime"]
CMD ["--version"] 
