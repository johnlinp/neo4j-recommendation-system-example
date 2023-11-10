source config.bash

RANDOM_GDS_PROJECTION_KEY="$(date +%s)"
RUN_ALGORITHM_CYPHER="
    CALL gds.graph.project('embedding-projection-${RANDOM_GDS_PROJECTION_KEY}',
        ['${MAIN_NODE_LABEL}', '${ITEM_NODE_LABEL}'],
        { ${RELATIONSHIP_TYPE}: { orientation: 'UNDIRECTED' } }
    );
    CALL gds.fastRP.mutate('embedding-projection-${RANDOM_GDS_PROJECTION_KEY}', {
        mutateProperty: 'embedding',
        embeddingDimension: 256,
        randomSeed: 7474
    });
    CALL gds.graph.nodeProperties.write('embedding-projection-${RANDOM_GDS_PROJECTION_KEY}',
        ['embedding'],
        ['${ITEM_NODE_LABEL}']
    );

    CALL gds.graph.project('cf-projection-${RANDOM_GDS_PROJECTION_KEY}',
        { ${ITEM_NODE_LABEL}: { properties: ['embedding']}},
        '*'
    );
    CALL gds.knn.write('cf-projection-${RANDOM_GDS_PROJECTION_KEY}', {
        nodeProperties: ['embedding'],
        writeRelationshipType: 'SIMILAR_TO',
        writeProperty: 'score',
        sampleRate: 1.0,
        maxIterations: 1000
    });
"
set -e

echo "Running Recommendation algorithm from Neo4j database ${NEO4J_DOCKER_NAME}..."
docker exec ${NEO4J_DOCKER_NAME} cypher-shell --user neo4j --password ${NEO4J_PASSWORD} "${RUN_ALGORITHM_CYPHER}"
