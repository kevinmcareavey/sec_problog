#!/bin/bash
results="../results/inference_queries"
mkdir -p "$results"
echo -e "\tinfer([happens(e(S,A),T),subject(e(S,A),S),act(e(S,A),A)])"
cat "$results/kb.log" | tr -d '[:blank:]' | sed 's/:/\t/g' | sed 's/infer(\[happens(e(/{S\//g' | sed 's/),/,T\//g' | sed 's/,T\/subject/}\t/g' | sed 's/sit/A\/sit/g' | sed 's/stand/A\/stand/g' | cut -f1,3
