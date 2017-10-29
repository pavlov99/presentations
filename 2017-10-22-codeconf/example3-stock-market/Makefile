.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: tsv
# target: tsv - Convert source CS.csv data to tab-separated format with the header
tsv:
	cat <(echo '# Date,Open,High,Low,Close,Volume') <(tail -n+2 CS.csv | cut -d, -f1,2,3,4,6,7) | tr ',' '\t' > cs.tsv

.PHONY: weekly
# target: weekly - Convert daily stock data to weekly
weekly:
	bash scripts/1-convert-daily-to-weekly.sh cs.tsv | ttail | tsrt -k Week:desc | tpretty

.PHONY: metrics
# target: metrics - calculate metrics based on daily stock data
metrics:
	bash scripts/2-calculate-metrics.sh cs.tsv > metrics.tsv

.PHONY: plot
# target: plot - plot metrics with Gnuplot
plot:
	cat metrics.tsv | ttail -n121 | tplot -c scripts/plot.gnu > metrics.png

.PHONY: imgcat
# target: imgcat - poorly simulate iTerm's imgcat with feh (apt-get install feh)
imgcat:
	feh metrics.png
