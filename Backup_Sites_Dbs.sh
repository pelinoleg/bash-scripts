#!/bin/bash

wget --recursive --no-parent  -nH  ftp://user:pass@ip/* -P /volume1/Dropbox/Backup/DigitalOcean/$(date +%d.%m.%Y)/
