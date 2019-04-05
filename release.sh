set -e
PART=$1
RELEASE=$(bump2version --dry-run --list $PART | grep new_version | cut -d '=' -f2)
bump2version $PART 
git checkout $RELEASE
docker build -t cruiseh/hello-world-golang-server:latest -t cruiseh/hello-world-golang-server:$(git log -1 --format=%h) -t $RELEASE .
docker push cruiseh/hello-world-golang-server
git push --tags
git checkout master