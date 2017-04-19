#!/usr/bin/env python3 

import requests
import time

try:
    print("...", flush=True)
    time.sleep(2)
    r = requests.get('https://api.kraken.com/0/public/Ticker?pair=BTCEUR')
    ticker = r.json()
    print('%.2f€' % float(ticker['result']['XXBTZEUR']['c'][0]), flush=True)
except Exception as e:
    print("Error", flush=True)

