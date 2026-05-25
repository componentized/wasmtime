ARG from_build from_base
FROM ${from_build} AS build
ARG wasmtime_crate wasmtime_git_rev
RUN \
  if [ "${wasmtime_crate}" = "" ] ; then \
    cargo install \
      --git https://github.com/bytecodealliance/wasmtime.git \
      --rev "${wasmtime_git_rev}" \
      --locked \
      wasmtime-cli \
    ; \
  else \
    cargo install \
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
