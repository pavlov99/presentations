awk -F, '{count[$1]++}END{for (key in count) print int(key) ": " count[key]}' HIGGS.csv

real	0m14.275s
user	0m9.700s
sys	0m2.032s

awk -F, '{v = $3 > v ? $3 : v}END{print v}' HIGGS.csv
2.434867858886718750e+00

real	0m12.844s
user	0m10.864s
sys	0m1.536s

awk -F, '{count[$1]++; sum[$1] += $4}END{for (key in count) print int(key) ": " sum[key] / count[key]}' HIGGS.csv
1: 0.000595945
0: -0.000700042

real	0m12.536s
user	0m11.204s
sys	0m1.332s

# awk -F, '{print $1, $23, $28}' header.txt
# NOTE: need to convert numbers to floats, so sort works faster.
awk -F, 'BEGIN{OFS=","}{if($23 > 0.75) print $1, $23,$28}' HIGGS.csv | sort -t, -k3 -g > 3-awk.csv

real	1m47.702s
user	1m43.708s
sys	0m3.488s

awk -F, '{if($23 > 0.75) printf "%.1f,%.12f,%.12f\n", $1, $23, $28}' HIGGS.csv | sort -t, -k3 -n > 3-awk.csv
real	0m36.370s
user	0m35.576s
sys	0m2.256s
