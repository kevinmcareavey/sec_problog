#!/bin/bash
queries="../queries"
results="../results/inference_queries"
mkdir -p "$results"
echo -n "running..."
cat "$queries/inference_queries.pl" ../event_narrative.pl ../effect_clauses.pl ../initial_beliefs.pl ../inference_rules.pl ../sec_axioms.pl > kb.pl
problog kb.pl --output "$results/kb.log"
rm kb.pl
echo "done."
