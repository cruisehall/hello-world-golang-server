# Hello World - GoLang Server

## Prerequisites

- [Release plugin: bump2version](https://github.com/c4urself/bump2version)
- [Kustomize](https://github.com/kubernetes-sigs/kustomize)

## Development

### Build

```sh
docker build -t cruiseh/hello-world-golang-server:latest .
```

### Test

#### With Docker

```sh
docker run -it --rm -p 8888:8888 --name hello-world-server cruiseh/hello-world-golang-server
```

Navigate to http://localhost:8888

#### With Kubernetes

After deploying `k8s/deployment.yaml` & `k8s/service.yaml` in the `hw-go` namespace, configure port forwarding to the `hello-go` service with the command:

```sh
kubectl port-forward svc/hello-go -n hw-go 8888:8888
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