source config.bash

set -e

echo "Deleting Neo4j database ${NEO4J_DOCKER_NAME}..."
docker rm -f ${NEO4J_DOCKER_NAME}
