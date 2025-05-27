#!/usr/bin/env python3
import requests
import sys
import os

url = os.environ["DISCORD_URL"]

report = str(sys.stdin.read())
contents = {"content": report}
requests.post(url, json=contents)
