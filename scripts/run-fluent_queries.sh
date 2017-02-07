#!/bin/bash
queries="../queries"
results="../results/fluent_queries"
mkdir -p "$results"
while read i
do
	echo -n "$i..."
	sed s/,T\)/,"$i"\)/g "$queries/fluent_queries.pl" > ground_fluent_queries.pl
	cat ground_fluent_queries.pl ../event_narrative.pl ../effect_clauses.pl ../initial_beliefs.pl ../inference_rules.pl ../sec_axioms.pl > kb.pl
	problog kb.pl --output "$results/kb-$i.log"
	rm ground_fluent_queries.pl
	rm kb.pl
	echo "done."
done < timepoints.rc
