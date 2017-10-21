# Data Processing Example: Higgs boson from UCI repository

### Example problem statement

This presentation uses UCI machine learning [Higgs boson](http://archive.ics.uci.edu/ml/datasets/HIGGS) data: 11M objects, 28 attributes, 7.5Gb unarchived. 

```bash
# takes 15sec.
> time wc -l HIGGS.csv
11000000 HIGGS.csv

real	0m15.692s
user	0m0.540s
sys	0m2.828s
```
#### Questions:
1. What is the maximum value of `lepton_eta`?
2. What is the average value of `lepton_phi` by class 0 and 1?
3. Filter objects with `m_jj` > 0.75 (8,906,303 objects) and sort them by `m_wbb`.

NOTE: Typical questions for business analysts. Or previous stage of machine learning.
Column names do not matter for this illustration. Usually a devloper/analyst would now their meaning.

#### Possible solutions:
1. In-memory Python with [Pandas](http://pandas.pydata.org/).
2. Database SQL queries with PostgreSQL and Docker.
3. Command line with AWK.

### Reality Check
It’s not as agile as it seems. You work inside the company network.
1. You don’t have sudo rights and your admin does not want to install anything for you. Like no database or user privileges, etc.
2. The server does not have GitHub/Internet access and the only deployment possible is Java JARs or C/C++/etc. So, no NodeJS/Python packages. And of course no R/Matlab/Excel.
3. Get better at command line tools ;)

### Results
Dell xps 15, 16Gb RAM, 8 CPUs:

|| Python | PostgreSQL | gawk | mawk | Tabtools |
|---|---|---|---|---|---|
| Read time | 104.4 | 180.3 | 0 | 0 | 0 |
| Q1: "max" time | 0 | 15.2 | 22.8 | 12.2 | 12.8 |
| Q2: "group + avg" time | 0 | 5.8 | 30.5 | 12.6 | 26.6* |
| Q3: "filter + sort" time | 21.3 | 33.6 | 174.2 | 36.3 | 33.5
| Total, sec. | 125.7 | 243.9 | 227.5 | **61.1** | 72.9 |

Uses $\Omega(n log(n))$ complexity instead of $\Omega(n)$. Could be improved.
