#!/bin/bash

# Calculate financial metrics based on open/high/low/close/volume data.
# Usage: bash 2-calculate-metrics.sh file.tsv

cat $1 \
    | tawk -o 'Date; Open; High; Low; Close; Volume' \
        -o 'MA200 = AVG(Close, 200)' \
        -o 'MA50 = AVG(Close, 50)' \
        -o 'EMA26 = EMA(Close, 26)'  \
        -o 'EMA13 = EMA(Close, 13)'  \
        -o 'FastMACD = EMA(Close, 12) - EMA26' \
        -o 'SlowMACD = EMA(FastMACD, 9)' \
        -o 'MACDHistogram = FastMACD - SlowMACD' \
        -o '_MACDSlope = MACDHistogram - PREV(MACDHistogram)' \
        -o '_EMA13Slope = EMA13 - PREV(EMA13)' \
        -o 'ImpulseIndex = 1 if (_MACDSlope > 0 and _EMA13Slope > 0) else -1 if (_MACDSlope < 0 and _EMA13Slope < 0) else 0' \
        -o '_PrevClose = PREV(Close)' \
        -o 'CloseSlope = Close - _PrevClose' \
        -o 'CloseMin14 = MIN(Close, 14)' \
        -o 'CloseMax14 = MAX(Close, 14)' \
        -o '_RawStochasticNumerator = Close - CloseMin14' \
        -o '_RawStochasticDenominator = CloseMax14 - CloseMin14' \
        -o '_RawStochasticNumerator3 = SUM(_RawStochasticNumerator, 3)' \
        -o '_RawStochasticDenominator3 = SUM(_RawStochasticDenominator, 3)' \
        -o 'FastStochasticK = _RawStochasticNumerator / _RawStochasticDenominator * 100 if _RawStochasticDenominator else 0' \
        -o 'FastStochasticD = _RawStochasticNumerator3 / _RawStochasticDenominator3 * 100 if _RawStochasticDenominator3 else 0' \
        -o '_SlowStochasticNumerator3 = SUM(_RawStochasticNumerator3, 3)' \
        -o '_SlowStochasticDenominator3 = SUM(_RawStochasticDenominator3, 3)' \
        -o 'SlowStochasticK = FastStochasticD' \
        -o 'SlowStochasticD = _SlowStochasticNumerator3 / _SlowStochasticDenominator3 * 100 if _SlowStochasticDenominator3 else 0'
