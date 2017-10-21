.PHONY: example1
example1:
	cat codeconf.md | awk '{w += NF}END{print NR, w}'

.PHONY: example2
example2:
	cat codeconf.md \
	    | awk '{for(i=1; i<=NF; i++) words[$$i]++}END{for(w in words) print w, words[w]}' \
	    | sort -k2 -nr \
	    | head -n35

.PHONY: example3
example3:
	cat codeconf.md | awk '{l = length > length(l) ? $0 : l}END{print length(l), l}'
