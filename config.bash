NEO4J_DOCKER_NAME=movie-recommender
NEO4J_PASSWORD=toystory
NEO4J_VERSION=5.13.0

PREPARED_DATASET_MAIN_NODE_PATH=./user.csv
PREPARED_DATASET_ITEM_NODE_PATH=./movie.csv
PREPARED_DATASET_RELATIONSHIP_PATH=./user-watch-movie-history.csv
MAIN_NODE_LABEL=User
MAIN_NODE_ID_COLUMN=UserId
MAIN_NODE_NAME_COLUMN=UserName
ITEM_NODE_LABEL=Movie
ITEM_NODE_ID_COLUMN=MovieId
ITEM_NODE_NAME_COLUMN=MovieName
RELATIONSHIP_TYPE=WATCHED

TARGET_MAIN_NODE_ID=7788
