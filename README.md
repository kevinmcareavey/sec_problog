# SEC ProbLog

This document describes how to run an SEC ProbLog program (McAreavey et al. 2017) that has been used to model an event detection data set obtained from vision analytics of bus surveillance video (Hong et al. 2016).  The original data set, and details about how it was translated to an SEC ProbLog program, can be found in the `dataset` directory.

## Running Queries

The SEC ProbLog program consists of the following files:

| File | Description |
| --- | --- |
| `event_narrative.pl` | Probabilistic event narrative |
| `effect_clauses.pl` | Probabilistic effect clauses |
| `initial_beliefs.pl` | Initial probabilistic beliefs |
| `inference_rules.pl` | Probabilistic inference rules |
| `sec_axioms.pl` | SEC axioms |

A complete ProbLog2 program `kb.pl` can be generated by concatenating these files as follows:

```shell
$ cat event_narrative.pl effect_clauses.pl initial_beliefs.pl inference_rules.pl sec_axioms.pl > kb.pl
```

Probabilistic atoms can then be queried with `problog` after inserting special atoms of the form `query(X)` into the new ProbLog2 program `kb.pl`:

```shell
$ echo "query(holdsAt(orientation(S,O),1171))." >> kb.pl
$ problog kb.pl
 holdsAt(orientation(p1,sitting),1171): 0.74913354
holdsAt(orientation(p1,standing),1171): 0.25086646
holdsAt(orientation(p2,standing),1171): 1
```

Refer to the ProbLog2 [website](https://dtai.cs.kuleuven.be/problog) for more usage information.

## Results

There are two tab-separated files containing formatted query results:

| File | Description |
| --- | --- |
| `results/fluent_queries.tsv` | Results for all `holdsAt(F,T)` atoms for significant timepoints specified in `scripts/timepoints.rc` |
| `results/inference_queries.tsv` | Results for all `infer(X)` atoms derived from the inference rule in `inference_rules.pl` |

If desired, these results can be regenerated as follows:

```shell
$ cd scripts
$ ./run.sh
```

## References
- Xin Hong, Yan Huang, Wenjun Ma, Sriram Varadarajan, Paul Miller, Weiru Liu, Maria Jose Santofimia Romero, Jesus Martinez del Rincon, and Huiyu Zhou. Evidential event inference in transport video surveillance. _Computer Vision and Image Understanding_ 144:276-297, 2016.
- Kevin McAreavey, Kim Bauters, Weiru Liu, and Jun Hong. The event calculus in probabilistic logic programming with annotated disjunctions. In _Proceedings of the 16th International Conference on Autonomous Agents and Multiagent Systems (AAMAS'17)_, to appear.
