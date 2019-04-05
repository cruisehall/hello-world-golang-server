# Hello World - GoLang Server

## Prerequisites

- [Release plugin: bump2version](https://github.com/c4urself/bump2version)

## Development

### Build

```sh
docker build -t $(cat repo.txt):latest .
```

### Test

```sh
docker run -it --rm -p 8888:8888 --name hello-world-server $(cat repo.txt)
```

Navigate to http://localhost:8888

## Release

### Create new release

```sh
./release.sh (patch|minor|major)
```

### Publish current release

Builds docker image from current release, tags with `latest`, version and commit SHA

```sh
./publish.sh
```

## Helpful commands

### Get current release

```sh
bump2version --dry-run --list patch | grep current_version | cut -d '=' -f2
```