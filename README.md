# Hello World - GoLang Server

## Prerequisites

- [Release plugin: bump2version](https://github.com/c4urself/bump2version)

## Building

```sh
docker build -t cruiseh/hello-world-golang-server:latest -t cruiseh/hello-world-golang-server:$(git log -1 --format=%h) -t cruiseh/hello-world-golang-server:$(bump2version --dry-run --list patch | grep current_version | cut -d '=' -f2) .
```

## Publish new release

```sh
./release.sh patch
```
## Running locally on port 8888

```sh
docker run -it --rm -p 8888:8888 --name hello-world-server cruisehall/hello-world-golang-server
```

## Helpful commands

### Get current release

```sh
bump2version --dry-run --list patch | grep current_version | cut -d '=' -f2
```