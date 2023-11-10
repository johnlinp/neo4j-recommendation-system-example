source config.bash

set -e

echo "Creating Docker container for Neo4j database ${NEO4J_DOCKER_NAME}..."
docker run \
    --name ${NEO4J_DOCKER_NAME} \
    -p7474:7474 -p7687:7687 \
    -d \
    --env NEO4J_AUTH=neo4j/${NEO4J_PASSWORD} \
    --env NEO4J_PLUGINS='["graph-data-science"]' \
    neo4j:${NEO4J_VERSION}

set +e
echo "Checking if Neo4j database ${NEO4J_DOCKER_NAME} is up..."
NEO4J_READY=NO
for _ in $(seq 60)
do
    curl -s http://localhost:7474/ > /dev/null
    if [ "$?" = "0" ]
    then
        NEO4J_READY=YES
        break
    fi
    sleep 1
done
set -e

if [ "${NEO4J_READY}" = "YES" ]
then
    echo "Neo4j database ${NEO4J_DOCKER_NAME} is up!"
else
    echo "Neo4j database ${NEO4J_DOCKER_NAME} is not ready, please type 'docker logs ${NEO4J_DOCKER_NAME}' to find out why."
fi
