# Prepare tab-separated file:
cat <(printf "# ") <(cat header.txt) <(cat HIGGS.csv) | tr ',' '\t' > HIGGS.tsv

cat HIGGS.tsv | tawk -o 'signal=int(signal);m_jj;m_wbb=0+m_wbb' -f 'm_jj>0.75' | tsrt -k m_wbb:asc:numeric > 4-tawk.csv
real	0m33.891s
user	0m33.248s
sys	0m6.796s
