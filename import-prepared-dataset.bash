source config.bash

IMPORT_PREPARED_DATASET_CYPHER="
    LOAD CSV WITH HEADERS FROM 'file:///prepared-dataset.csv' AS row
    MERGE (n:${MAIN_NODE_LABEL} {id: row.${MAIN_NODE_ID_COLUMN}, name: row.${MAIN_NODE_NAME_COLUMN}})
    MERGE (m:${ITEM_NODE_LABEL} {id: row.${ITEM_NODE_ID_COLUMN}, name: row.${ITEM_NODE_NAME_COLUMN}})
    MERGE (n)-[:${RELATIONSHIP_TYPE}]->(m);
"

set -e

echo "Importing prepared dataset ${PREPARED_DATASET_PATH} into Neo4j database ${NEO4J_DOCKER_NAME}..."
docker cp ${PREPARED_DATASET_PATH} ${NEO4J_DOCKER_NAME}:/var/lib/neo4j/import/prepared-dataset.csv
docker exec ${NEO4J_DOCKER_NAME} cypher-shell --user neo4j --password ${NEO4J_PASSWORD} "${IMPORT_PREPARED_DATASET_CYPHER}"
echo "Done importing prepared dataset ${PREPARED_DATASET_PATH} into Neo4j database ${NEO4J_DOCKER_NAME}!"
