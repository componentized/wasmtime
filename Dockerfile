ARG from_build from_base
FROM ${from_build} AS build
ARG wasmtime_crate wasmtime_git_rev cargo_auditable_version
RUN \
  cargo install --locked "cargo-auditable@${cargo_auditable_version}" ; \
  if [ "${wasmtime_crate}" = "" ] ; then \
    # work around https://github.com/rust-secure-code/cargo-auditable/issues/124#issuecomment-1693428978
    # cargo install \
    #   --git https://github.com/bytecodealliance/wasmtime.git \
    #   --rev "${wasmtime_git_rev}" \
    #   --locked \
    #   wasmtime-cli \
    # ; \
    mkdir wasmtime ; cd wasmtime ; git init ; \
    git fetch --depth 1 https://github.com/bytecodealliance/wasmtime.git ${wasmtime_git_rev} && git reset --hard FETCH_HEAD && git submodule update --init --depth 1; \
    find . -name Cargo.toml | xargs sed -i 's/dep:pulley-interpreter/pulley-interpreter/' ; \
    cargo auditable install \
      --locked \
      --path . \
    ; \
  else \
    cargo auditable install \
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
