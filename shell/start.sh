#!/bin/bash
python /app/python/init.py
jupyter notebook --notebook-dir=/app --ip=0.0.0.0 --port=8888 --no-browser