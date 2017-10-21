#!/bin/bash

# Prepare tab-separated file:
# cat <(printf "# ") <(cat header.txt) <(cat HIGGS.csv) | tr ',' '\t' > HIGGS.tsv

function get_max_lepton_eta {
    # mawk time: 15.212s
    # gawk time: 12.801s
    cat HIGGS.tsv \
        | tawk -o 'm=MAX(lepton_eta)' \
        | tail -n1  # or ttail -n1 -N
}

function get_avg_lepton_phi_by_signal {
    # mawk time: 30.657s
    # gawk time: 26.621s
    cat HIGGS.tsv \
        | tawk -o 'signal=int(signal);lepton_phi' \
        | tsrt -k signal \
        | tgrp \
            -k signal -g 'avg=SUM(lepton_phi)/COUNT(lepton_phi)' \
        | tail -n+2
}

function filter_sort_output {
    # mawk time: 33.516s
    # gawk time: 43.408s
    cat HIGGS.tsv \
        | AWKPATH=$(which mawk) tawk \
            -o 'signal=int(signal);m_jj;m_wbb=0+m_wbb' \
            -f 'm_jj>0.75' \
        | tsrt -k m_wbb:asc:numeric > 4-tabtools.csv
}

echo "Q1: max value of lepton_eta: "$(time get_max_lepton_eta)
echo "Q2: average value of lepton_phi by class: "$(time get_avg_lepton_phi_by_signal)
echo "Q3: Filter, sort and output: "$(time filter_sort_output)
