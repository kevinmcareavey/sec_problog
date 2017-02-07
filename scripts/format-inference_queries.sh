#!/bin/bash
results="../results/inference_queries"
mkdir -p "$results"
echo -e "\tinfer([happens(e(S),T),subject(e(S),S),act(e(S),sit)])"
cat "$results/kb.log" | tr -d '[:blank:]' | sed 's/:/\t/g' | sed 's/infer(\[happens(e(/{S\//g' | sed 's/),/,T\//g' | sed 's/,T\/subject/}\t/g' | cut -f1,3
