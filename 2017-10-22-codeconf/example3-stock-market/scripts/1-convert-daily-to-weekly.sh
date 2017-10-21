#!/bin/bash

# Convert input daily stock data to weekly
# Usage: bash 1-convert-daily-to-weekly.sh file.tsv
# Note: this works with GNU awk only (aka gawk) as it has
# strftime and mktime functions.

cat $1 | tgrp \
    -k "Week=strftime(\"%U\", DateEpoch(Date))" \
    -g "Date=FIRST(Date)" \
    -g"Open=FIRST(Open)" \
    -g "High=MAX(High)" \
    -g "Low=MIN(Low)" \
    -g "Close=LAST(Close)" \
    -g "Volume=SUM(Volume)"
