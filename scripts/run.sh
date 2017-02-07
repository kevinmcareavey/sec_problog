#!/bin/bash
results="../results"

echo "running fluent queries..."
./run-fluent_queries.sh
echo "formatting output of fluent queries..."
./format-fluent_queries.sh > "$results/fluent_queries.tsv"
echo "cleaning temporary files from fluent queries..."
rm -rf "$results/fluent_queries"

echo "running inference queries..."
./run-inference_queries.sh
echo "formatting output of inference queries..."
./format-inference_queries.sh > "$results/inference_queries.tsv"
echo "cleaning temporary files from inference queries..."
rm -rf "$results/inference_queries"

