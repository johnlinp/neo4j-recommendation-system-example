source config.bash

SHOW_ITEMS_CYPHER="
    MATCH(n:${MAIN_NODE_LABEL} {id: '${TARGET_MAIN_NODE_ID}'})-[:${RELATIONSHIP_TYPE}]->(m:${ITEM_NODE_LABEL})
    RETURN m.name as itemName;
"

SHOW_RECOMMENDATION_CYPHER="
    MATCH(n:${MAIN_NODE_LABEL} {id: '${TARGET_MAIN_NODE_ID}'})-[:${RELATIONSHIP_TYPE}]->(m:${ITEM_NODE_LABEL})
    WITH collect(id(m)) AS lovedItems
    MATCH (item:${ITEM_NODE_LABEL})-[s:SIMILAR_TO]->(similarItem:${ITEM_NODE_LABEL})
    WHERE id(item) IN lovedItems
    AND NOT id(similarItem) IN lovedItems
    RETURN DISTINCT similarItem.name as itemName, sum(s.score) AS totalScore
    ORDER BY totalScore DESC;
"

set -e

echo "Showing current items for ${MAIN_NODE_LABEL}:${TARGET_MAIN_NODE_ID} from Neo4j database ${NEO4J_DOCKER_NAME}..."
docker exec ${NEO4J_DOCKER_NAME} cypher-shell --user neo4j --password ${NEO4J_PASSWORD} "${SHOW_ITEMS_CYPHER}"

echo "Showing Recommendation for ${MAIN_NODE_LABEL}:${TARGET_MAIN_NODE_ID} from Neo4j database ${NEO4J_DOCKER_NAME}..."
docker exec ${NEO4J_DOCKER_NAME} cypher-shell --user neo4j --password ${NEO4J_PASSWORD} "${SHOW_RECOMMENDATION_CYPHER}"
