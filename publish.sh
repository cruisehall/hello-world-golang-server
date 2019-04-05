set -e
DOCKER_REPO=$(cat repo.txt)
RELEASE_VERSION=$(bump2version --dry-run --list patch | grep current_version | cut -d '=' -f2)
echo "===   Publishing version: [$RELEASE_VERSION]"
git checkout $RELEASE_VERSION
RELEASE_COMMIT=$(git log -1 --format=%h)
echo "===   Checked out git tag: [$RELEASE_VERSION][$RELEASE_COMMIT]"
docker build -t $DOCKER_REPO:latest -t $DOCKER_REPO:$RELEASE_COMMIT -t $DOCKER_REPO:$RELEASE_VERSION .
docker push $DOCKER_REPO
git checkout master