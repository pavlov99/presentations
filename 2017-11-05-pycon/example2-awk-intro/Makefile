.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: csv2tsv
# target: csv2tsv - Convert csv data to tab separated file
csv2tsv:
	cat <(printf '# ') <(cat pycon-schedule.csv) | tr ',' '\t' > pycon-schedule.tsv

.PHONY: example1
example1:
	cat pycon-schedule.tsv \
	    | tawk -o 'speaker' -f 'speaker' \
	    | tsrt -N \
	    | uniq \
	    | wc -l

.PHONY: example2
example2:
	cut -d, -f5 pycon-schedule.csv \
	    | tail -n+2 \
	    | awk '{for(i=1; i<=NF; i++) w[$$i]++}END{for(i in w) print w[i], i}' \
	    | sort -r \
	    | head

.PHONY: example3
example3:
	cat pycon-schedule.tsv \
	    | tawk -a -f 'speaker' -o 'key=timeslot if day == 1 else gensub("-", "+", "g", timeslot)' \
	    | tgrp -k key -g 'day=FIRST(day)' -g 'timeslot=FIRST(timeslot)' -g 'venue=FIRST(venue)' -g 'speaker=FIRST(speaker)' -g 'title=FIRST(title)' -g 'sessions=COUNT()' \
	    | tawk -o 'day;timeslot;venue;speaker;title' -f 'sessions==1' \
	    | tpretty
