# Wasmtime Images <!-- omit in toc -->

Images with wasmtime embedded.

- [Community](#community)
  - [Code of Conduct](#code-of-conduct)
  - [Communication](#communication)
  - [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)
- [License](#license)

This project aims to track new [Wasmtime](https://wasmtime.dev) releases packaging them as publicly available OCI images hosted on the GitHub Container Registry (`ghcr.io`). New images are built using the latest stable version of rust for `linux/amd64` and `linux/arm64`.

```sh
docker pull ghcr.io/componentized/wasmtime
```

The packages page on GitHub contains a [full list of available images](https://github.com/orgs/componentized/packages?repo_name=wasmtime). 

Images are published to state and dev repositories. Tags within each repository follow these pattens:

- [`ghcr.io/componentized/wasmtime`](https://github.com/componentized/wasmtime/pkgs/container/wasmtime)
  - `:v{major}.{minor}.{patch}`
  - `:v{major}.{minor}` - most recent release for this major and minor versions
  - `:v{major}` - most recent release for this major version
  - `:stable` - most recent release
  - `:stable-1` - most recent release for the previous major line
  - `:lts` - most recent lts release
  - `:lts-1` - most recent release for the previous lts line
- [`ghcr.io/componentized/wasmtime/dev`](https://github.com/componentized/wasmtime/pkgs/container/wasmtime%2Fdev)
  - `:dev-{yyyy}-{mm}-{dd}` - most recent dev build from this commit date
  - `:dev-{gitsha}` - dev build for this git sha
  - `:dev` - most recent dev build

A good faith effort is made to capture the latest stable and dev releases. It's possible an individual release may not be published. Please [open an issue](https://github.com/componentized/wasmtime/issues) if an important build is not available within a reasonable period of time.

## Community

### Code of Conduct

The Componentized project follow the [Contributor Covenant Code of Conduct](./CODE_OF_CONDUCT.md). In short, be kind and treat others with respect.

### Communication

General discussion and questions about the project can occur in the project's [GitHub discussions](https://github.com/orgs/componentized/discussions).

### Contributing

The Componentized project team welcomes contributions from the community. A contributor license agreement (CLA) is not required. You own full rights to your contribution and agree to license the work to the community under the Apache License v2.0, via a [Developer Certificate of Origin (DCO)](https://developercertificate.org). For more detailed information, refer to [CONTRIBUTING.md](CONTRIBUTING.md).

## Acknowledgements

[Wasmtime](https://wasmtime.dev) is a [Bytecode Alliance](https://bytecodealliance.org) project. This project is a packaging of the upstream project and would not exist without their efforts.

This project was conceived in discussion between [Mark Fisher](https://github.com/markfisher) and [Scott Andrews](https://github.com/scothis).

## License

Apache License v2.0: see [LICENSE](./LICENSE) for details.
