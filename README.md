# Hello World - GoLang Server

## Prerequisites

- [Release plugin: bump2version](https://github.com/c4urself/bump2version)

## Building

```sh
docker build -t $(cat repo.txt):latest .
```

## Create new release

```sh
./release.sh (patch|minor|major)
```
## Running the latest image locally on port 8888

```sh
docker run -it --rm -p 8888:8888 --name hello-world-server $(cat repo.txt)
```

## Helpful commands

### Get current release

```sh
bump2version --dry-run --list patch | grep current_version | cut -d '=' -f2
```