#!/bin/bash

function get_max_lepton_eta {
    # time: 12.560s
    awk -F, '{v = $3 > v ? $3 : v}END{print v}' HIGGS.csv
}

function get_avg_lepton_phi_by_signal {
    # time: 13.034s
    awk -F, '{
        count[$1]++; sum[$1] += $4
    } END {
        for (key in count) print int(key) ": " sum[key] / count[key]
    }' HIGGS.csv
}

function filter_sort_output {
    # Check header: which name correspond to which column?
    # awk -F, '{print $1, $23, $28}' header.txt

    # NOTE: need to convert numbers to floats, so sort works faster.
    # time: 37.715s
    awk -F, '{
        if($23 > 0.75) printf "%.1f,%.12f,%.12f\n", $1, $23, $28
    }' HIGGS.csv | sort -t, -k3 -n > 3-awk.csv
}

echo "Q1: max value of lepton_eta: "$(time get_max_lepton_eta)
echo "Q2: average value of lepton_phi by class: "$(time get_avg_lepton_phi_by_signal)
echo "Q3: Filter, sort and output: "$(time filter_sort_output)
