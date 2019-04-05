set -e
PART=${1?Must set bump version part (patch|minor|major)}
DOCKER_REPO=$(cat repo.txt)
echo "===   Performing bump2version release: [$PART]"
BRANCH=$(git branch -a | grep '*' | cut -d ' ' -f2)
echo "===   Releaseing from branch: [$BRANCH]"
RELEASE_VERSION=$(bump2version --dry-run --list $PART | grep new_version | cut -d '=' -f2)
echo "===   Target Version: [$RELEASE]"
bump2version $PART 
echo "===   Successfully executed release"
git checkout $RELEASE_VERSION
RELEASE_COMMIT=$(git log -1 --format=%h)
echo "===   Checked out git tag: [$RELEASE_VERSION][$RELEASE_COMMIT]"
docker build -t $DOCKER_REPO:latest -t $DOCKER_REPO:$RELEASE_COMMIT -t $DOCKER_REPO:$RELEASE_VERSION -t $DOCKER_REPO:$BRANCH .
docker push $DOCKER_REPO
git push --tags
git checkout master