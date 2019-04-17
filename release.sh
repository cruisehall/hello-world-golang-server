set -e
if [[ $(git diff --stat) != '' ]]; then
  echo '===     ERROR: Working tree is dirty'
  exit 1
else
  echo 'clean'
fi
PART=${1?Must set bump version part (patch|minor|major)}
DOCKER_REPO=$(cat repo.txt)
echo "===   Performing bump2version release: [$PART]"
BRANCH=$(git branch -a | grep '*' | cut -d ' ' -f2)
echo "===   Releasing from branch: [$BRANCH]"
CURRENT_VERSION=$(bump2version --dry-run --list $PART | grep current_version | cut -d '=' -f2)
NEW_VERSION=$(bump2version --dry-run --list $PART | grep new_version | cut -d '=' -f2)
if [ -z "$NEW_VERSION" ]
then
    echo "===   ERROR: NEW_VERSION could not be set"
    exit 1
fi
echo "===   Bumping version: [$NEW_VERSION]"
bump2version --no-commit $PART

echo "===   Building Kubernetes Manifests"
rm -rf k8s/
mkdir -p k8s
mkdir -p k8s/dev
mkdir -p k8s/stage
mkdir -p k8s/prod
kustomize build ./k8s.d/dev | cat > k8s/dev/main.yaml
kustomize build ./k8s.d/stage | cat > k8s/stage/main.yaml
kustomize build ./k8s.d/prod | cat > k8s/prod/main.yaml

git add .
git commit -m  "Release: $CURRENT_VERSION -> $NEW_VERSION"

echo "===   Successfully executed release"
git push --tags
echo "===   Pushed release tags to GitHub"