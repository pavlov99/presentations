TODAY = "`date +%Y-%m-%d`"

set term png size 1280,960
set grid
set key inside left Left top horizontal
set lmargin 9

set timefmt '%Y-%m-%d'
# set xdata time  # use indexes instead dates to make chart prettier (without gaps).
set xrange [0:]

stats '__input' index 0 using __High prefix "High"
stats '__input' index 0 using __Low prefix "Low"
stats '__input' index 0 using __Close prefix "Close"
stats '__input' index 0 using __Volume prefix "Volume"

set multiplot

set yrange [Low_min - 0.25 * (High_max - Low_min):High_max + 0.1 * (High_max - Low_min)]
set y2range [0:Volume_max * 4]

# OHLC bars with Elder Impulse system
set size 1, 0.6
set origin 0, 0.4
set bmargin 0
set format x ""  # use x labels from bottom chart
set palette defined  (-1 'red', 0 'blue', 1 'green')
unset colorbox
set style fill solid 0.25 border

plot '__input' using 0:__Volume:($__CloseSlope > 0 ? 1 : -1) notitle with boxes axes x1y2 palette, \
  '' using 0:__Open:__High:__Low:__Close:($__ImpulseIndex > 0 ? 1 : $__ImpulseIndex < 0 ? -1 : 0) notitle with financebars lw 2 palette, \
  '' using 0:__MA50 title "MA(50)" with lines lc rgb '#8888C8', \
  '' using 0:__MA200 title "MA(200)" with lines lc rgb '#D00030', \
  '' using 0:__EMA13 title "EMA(13)" with lines lc rgb '#136d13', \

# MACD Histogram
set autoscale y
set size 1.0, 0.2
set origin 0.0, 0.2
set palette defined  (0 'red', 1 '#c0c0c0')
set style fill solid 1.0 border -1

plot '__input' using 0:__MACDHistogram title "MACD(26, 12, 9)" with boxes lt 3, \
    '' using 0:__FastMACD notitle with lines lt rgb 'black', \
    '' using 0:__SlowMACD notitle with lines lt rgb 'red'

# Slow Stochastic
set size 1.0, 0.2
set origin 0.0, 0.0
set tmargin 0
plot '__input' using 0:__SlowStochasticK title "%K(14)" with lines lt rgb 'black', \
    '' using 0:__SlowStochasticD title "%D(3)" with lines lt rgb 'red', \
    50 notitle with lines dashtype 2 lc rgb 'black'

unset multiplot
