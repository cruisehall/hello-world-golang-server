# Hello World - GoLang Server

## Prerequisites

- [Release plugin: bump2version](https://github.com/c4urself/bump2version)

## Building

```sh
docker build -t cruiseh/hello-world-golang-server:latest -t cruiseh/hello-world-golang-server:$(git log -1 --format=%h)  .
```

## Publishing

```sh
docker push cruiseh/hello-world-golang-server
```
## Running locally

```sh
docker run -it --rm --name hello-world-server cruisehall/hello-world-golang-server
```