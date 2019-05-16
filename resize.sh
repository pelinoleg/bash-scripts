#!/bin/bash

source="/volume1/Dropbox/Sort Images/Images operations/resize to 2000px"


find "$source"  -iname "*.jpg" | xargs -L1 -I{} convert -resize 2000X2000 "{}" _resized/"{}"




