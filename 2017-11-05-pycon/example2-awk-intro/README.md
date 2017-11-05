### Step 1: Use PyCon schedule in csv format

1. How many speakers?

```bash
cat pycon-schedule.tsv | tawk -o 'speaker' -f 'speaker' | tsrt -N | uniq | wc -l
```

There are 15 unique speakers.

2. The most popular word in topics?

```bash
cut -d, -f5 pycon-schedule.csv | tail -n+2 | awk '{for(i=1; i<=NF; i++) w[$i]++}END{for(i in w) print w[i], i}' | sort -r | head
```

Python! (Who could have guessed?)

3. Filter unique talks (one talk at a time).

Not all of the functions implemented, however, there are workarounds. For example, there is no support for composite group key.

It is possible to combine two keys in a tricky way. For day 1 use timeslot, for day 2 use timeslot with substituted character

```bash
cat pycon-schedule.tsv \
    | tawk -a -f 'speaker' -o 'key=timeslot if day == 1 else gensub("-", "+", "g", timeslot)' \
    | tgrp -k key -g 'day=FIRST(day)' -g 'timeslot=FIRST(timeslot)' -g 'venue=FIRST(venue)' -g 'speaker=FIRST(speaker)' -g 'title=FIRST(title)' -g 'sessions=COUNT()' \
    | tawk -o 'day;timeslot;venue;speaker;title' -f 'sessions==1'
```
