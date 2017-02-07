#!/bin/bash
results="../results/fluent_queries"
mkdir -p "$results"
list=""
first=""

while read i
do
	if [ "$first" == "" ]
	then
		first="$i"
	fi
	input="kb-$i.log"
	output="prob-$input"
	cat "$results/$input" | tr -d '[:blank:]' | cut -d ':' -f 2 > "$results/$output"
	list="$list $results/$output"
done < timepoints.rc

labels="labels-kb.log"
cat "$results/kb-$first.log" | tr -d '[:blank:]' | cut -d ':' -f 1 | sed s/,0\)/,T\)/g > "$results/$labels"

#echo -ne "holdsAt(...,T)"
while read i
do
	echo -ne "\t{T/$i}"
done < timepoints.rc
echo
paste $results/$labels $list

while read i
do
	rm "$results/prob-kb-$i.log"
done < timepoints.rc
rm "$results/$labels"
