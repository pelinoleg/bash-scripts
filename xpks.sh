#!/bin/bash
source="/volume1/Dropbox/Stock Photo"

#delete older 10 days
find "$source"  -name "*.xpks" -mtime +10 -type f -delete