#!/bin/bash
echo "IP addr: "
ip addr show wlp2s0 | /usr/bin/grep -Po "inet \K[\d.]+"
python -m http.server 8000
