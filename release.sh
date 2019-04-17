set -e
PART=${1?Must set bump version part (patch|minor|major)}
DOCKER_REPO=$(cat repo.txt)
echo "===   Performing bump2version release: [$PART]"
BRANCH=$(git branch -a | grep '*' | cut -d ' ' -f2)
echo "===   Releasing from branch: [$BRANCH]"
RELEASE_VERSION=$(bump2version --dry-run --list $PART | grep new_version | cut -d '=' -f2)
if [ -z "$RELEASE_VERSION" ]
then
    echo "===   ERROR: RELEASE_VERSION could not be set"
    exit 1
fi
echo "===   Bumping version: [$RELEASE_VERSION]"
bump2version $PART

echo "===   Building Kubernetes Manifests"
rm -rf k8s/
mkdir -p k8s
mkdir -p k8s/dev
mkdir -p k8s/stage
mkdir -p k8s/prod
kustomize build ./k8s.d/dev | cat > k8s/dev/main.yaml
kustomize build ./k8s.d/stage | cat > k8s/stage/main.yaml
kustomize build ./k8s.d/prod | cat > k8s/prod/main.yaml

echo "===   Successfully executed release"
git push --tags
echo "===   Pushed release tags to GitHub"