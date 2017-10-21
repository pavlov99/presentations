# AWK Intro in 5 minutes

### Important facts
* [AWK](https://en.wikipedia.org/wiki/AWK) - command line tool for streaming columnar data processing. Standard in unix-like OS.
* Actual AWK is outdated, use mawk (fast) or gawk (flexible).
* Limited data structures: strings, **associative arrays (hash maps)** and regexps.
* Built-in variables
    * $1, $2, … ($0 is entire record)
    * NR - number of processe lines (records)
    * NF - number of columns (fields)
* Use vars without declaration. Default values are 0s. One liners. Hipster friendly.

[Tutorial](http://www.grymoire.com/Unix/Awk.html) by Bruce Barnett. He [writes his blog in txt](http://www.grymoire.com/Unix/CshTop10.txt).

### Example program
```awk
BEGIN { print "START" }
      { print         }
END   { print "STOP"  }
```

### How to get the source file (for reference only)
Install [html2text](https://github.com/aaronsw/html2text).
```bash
wget codeconf.hk
html2text index.html > codeconf.md
```

### Examples
1. Count number of words and lines:
```bash
cat codeconf.md | awk '{w += NF}END{print NR, w}'

370 1445
```

2. Most popular words on codeconf.hk website (associative arrays, for-loop):
```bash
cat codeconf.md \
    | awk '{for(i=1; i<=NF; i++) words[$i]++}END{for(w in words) print w, words[w]}' \
    | sort -k2 -nr \
    | head -n35

...
Serverless 5
...
Android 5
...
```
NOTE: It is possible to use `tolower($i)` function of GAWK to account for upper and lower case. The result is the same.

Most popular non stop-words: "Serverles" and "Android". SEO winners: Davide Benvegnù and Richard Cohen. Both keywords are in titles, by the way ;)
![](./images/seo-serverless.png)
![](./images/seo-android.png)

3. Find longest line in the text (if-else example):
```bash
cat codeconf.md | awk '{l = length > length(l) ? $0 : l}END{print length(l), l}'

146   * We believe that the Hong Kong developer community is skilled and diverse, but that often these skills end up hidden away in big organisations.
```
