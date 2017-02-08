# SEC ProbLog: Data Set

This document desribes how an event detection data set from bus CCTV footage (Hong et al. 2016) was translated to an SEC ProbLog program (McAreavey et al. 2017).  The original data set relies on Dempster-Shafer (DS) theory (Shafer 1976); modelling uncertain information associated with an event using mass functions.

## Translating the Data Set

The original data set is included in the comma-separated file `dataset/original_events.csv`.  It contains 59 uncertain events, consisting of 5 different event types.  Each event has 2 mass functions: one associated with a start timepoint, and the other associated with an end timepoint.  The mass functions for a given event type are defined over the same frame (of discernment).  Events are deterministically assigned to one of two subjects: P1 or P2.

| Event type | Frame | Description |
| --- | --- | --- |
| PB (person boarding) | {MB, FB} | Male or female boarding |
| PM (person moving) | {MDR, MGW, MS1, ... ,M20} | Moving at door, in gangway, or at seat 1, ..., seat 20 |
| PSIT (person sitting) | {SIT1, ..., SIT20, ¬SIT} | Sitting in seat 1, ..., seat 20, or not sitting |
| PSTD (person standing) | {STD1, ..., STD20, ¬STD} | Standing at seat 1, ..., seat 20, or not standing |
| PE (person exiting) | {EXT, ¬EXT} | Exiting or not exiting |

In the original data set, events of type PB, PSIT, PSTD and PE are all instantaneous.  That is, the start and end timepoints (resp. mass functions) are identical.  Similarly, although PM events technically have duration, the start and end mass functions can be equivalently interpreted as two instananeous events.  Thus, we start by translating the original data set into a set of instananeous events.

Notice in the table above that the frames for PM, PSIT and PSTD events all provide location information.  Importantly, however, some of our new instantaneous PM events occur at the same timepoint as PSIT or PSTD events.  Thus, it is necessary to resolve conflicting location information provided by these events.  To achieve this, we will apply Dempster's rule of combination (Shafer 1976) to combine mass functions from those PM, PSIT and PSTD events which relate the same subject and which occur at the same timepoint.

Before we go any further however, notice that the frame for a PSIT (resp. PSTD) event prohibits the possibility that a person is sitting (resp. standing) at the door or in the gangway.  Conversely, notice that the frame for a PM events does not provide any information about orientation.  In order to combine these mass functions, we first apply the following multi-valued mapping in which we apply the standard approach to ignorance in DS theory:

| Original hypotheses | Multi-valued mapping | Description |
| --- | --- | --- |
| MB | M | Male |
| FB | F | Female |
| MDR | SITD, STDD | Sitting or standing at door |
| MGW | SITGW, STDGW | Sitting or standing in gangway |
| MS1 | SIT1, STD1 | Sitting or standing at seat 1 |
| ... | ... | ... |
| MS20 | SIT20, STD20 | Sitting or standing at seat 20 |
| ¬SIT | STDD, STDGW, STD1, ..., STD20 | Standing anywhere |
| ¬STD | SITD, SITGW, SIT1, ..., SIT20 | Sitting anywhere |
| EXT | T | True |
| ¬EXT | F | False |

For the purpose of this translation, the hypothesis ¬SIT (resp. ¬STD) is assumed to mean that the person is standing (resp. sitting) in any possible location.  Also, the hypotheses MB and FB have been simplified, since the the boarding action is deterministically modelled in the event type.  We thus arrive at the following frames:

| Event type | Frame |
| ---  | --- | --- |
| PB | {M, F} |
| PM | {SITD, SITGW, SIT1, ..., SIT20, STDD, STDGW, STD1, ..., STD20} |
| PSIT | {SITD, SITGW, SIT1, ..., SIT20, STDD, STDGW, STD1, ..., STD20} |
| PSTD | {SITD, SITGW, SIT1, ..., SIT20, STDD, STDGW, STD1, ..., STD20} |
| PE | {T, F} |

After deriving instantaneous events and applying this multi-valued mapping, we obtain the set of events included in `dataset/instantaneous_events.csv`.  We can then apply Dempster's rule to combine simulataneous PM, PSIT and PSTD events which relate to the same subject.

Finally, before we can translate the events to SEC ProbLog syntax, we need to transform the mass functions into probability distributions.  To achieve this, we apply Smets' Pignistic transformation (Smets 2005).  At this point, we can generate probabilistic event observations directly.

For PB events, we model the action deterministically, but the gender information probabilistically:

```prolog
happens(E,T).
subject(E,S).
act(E,boards).
P1::gender(E,male); ...; P2::gender(E,female).
```

For PM events, we ignore orientation information (since this was not included in the original data set):

```prolog
happens(E,T).
subject(E,S).
P1::location(E,door); P2::location(E,gangway); P3::location(E,seat(1)); ...; P22::location(E,seat(20)).
```

For PSIT and PSTD events, we include both location and orientation information:

```prolog
happens(E,T).
subject(E,S).
P1::location(E,door); P2::location(E,gangway); P3::location(E,seat(1)); ...; P22::location(E,seat(20)).
P1::orientation(E,sitting); P2::orientation(E,standing).
```

For PE events, we model the action probabilistically:

```prolog
happens(E,T).
subject(E,S).
P::act(E,exit).
```

In each case, the occurrence of the event is deterministic, as is the time at which it occurs and the subject to which it corresponds.

The complete translation of the data set as an SEC ProbLog event narrative can be found in the file `event_narrative.pl`.

## References
- Xin Hong, Yan Huang, Wenjun Ma, Sriram Varadarajan, Paul Miller, Weiru Liu, Maria Jose Santofimia Romero, Jesus Martinez del Rincon, and Huiyu Zhou. Evidential event inference in transport video surveillance. _Computer Vision and Image Understanding_ 144:276-297, 2016.
- Kevin McAreavey, Kim Bauters, Weiru Liu, and Jun Hong. The event calculus in probabilistic logic programs with annotated disjunctions. In _Proceedings of the 16th International Conference on Autonomous Agents and Multiagent Systems (AAMAS'17)_, to appear.
- Glenn Shafer. A Mathematical Theory of Evidence. Princeton University Press, 1976.
- Philippe Smets. Decision making in the TBM: the necessity of the pignistic transformation. _International Journal of Approximate Reasoning_, 38(2):133–147, 2005.

