#!/usr/bin/env python3

import requests

try:
    r = requests.get('https://api.kraken.com/0/public/Ticker?pair=BTCEUR');
    ticker = r.json()
    print('%.2f€' % float(ticker['result']['XXBTZEUR']['c'][0]))
except Exception as e:
    print("Error")
