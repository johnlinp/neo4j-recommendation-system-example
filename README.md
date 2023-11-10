# Neo4j Recommendation System Example

An simple example of recommendation system using Neo4j as the backend.

## Usage

1. Create the Neo4j database:
```
$ create-neo4j-db.bash
```
2. Import the prepared dataset:
```
$ import-prepared-dataset.bash
```
3. Run the recommendation algorithm:
```
$ run-recommendation-algorithm.bash
```
4. Show the recommendation results:
```
$ show-recommendation-results.bash
```

## Configuration

You can modify `config.bash` to use your own dataset.

## Visualization

Please go on <http://localhost:7474/> and login the Neo4j Browser to see the visualization of the graph.
The username should be `neo4j` and the password is in `config.bash`.
