#!/bin/bash

source="/volume1/Dropbox/Sort Images/RAW"
target="/volume1/Dropbox/Photo Source/RAW"


#DNG
find "$source" -type f -iname "*.dng" | while read file ; do
date=$(exiv2 "$file" 2> /dev/null | awk '/Image timestamp/ { print  $4 $5 }')
[ -z "$date" ] && echo "$file" >> ~/error.txt && continue

#example: Image timestamp : 2011:04:16 14:11:11

year=${date:0:4}

monthname=(ZERO January February March April May June July August September Octomber November December)
month=${monthname[10#${date:5:2}]}
monthn=${date:5:2}

day=${date:8:2}

hour=${date:10:2}
min=${date:13:2}
sec=${date:16:2}

mkdir -p "${target}/${year}"

n=$(($RANDOM % 100 + 1))

mv "$file" "${target}/${year}/${day} - ${month} - ${year}_${hour}.${min}.${sec}_$n.dng"

done


#TIF
find "$source" -type f -iname "*.tif" | while read file ; do
date=$(exiv2 "$file" 2> /dev/null | awk '/Image timestamp/ { print  $4 $5 }')
[ -z "$date" ] && echo "$file" >> ~/error.txt && continue

#example: Image timestamp : 2011:04:16 14:11:11

year=${date:0:4}

monthname=(ZERO January February March April May June July August September Octomber November December)
month=${monthname[10#${date:5:2}]}
monthn=${date:5:2}

day=${date:8:2}

hour=${date:10:2}
min=${date:13:2}
sec=${date:16:2}

mkdir -p "${target}/${year}"

n=$(($RANDOM % 100 + 1))

mv "$file" "${target}/${year}/${day} - ${month} - ${year}_${hour}.${min}.${sec}_$n.tif"

done





#NEF
find "$source" -type f -iname "*.nef" | while read file ; do
date=$(exiv2 "$file" 2> /dev/null | awk '/Image timestamp/ { print  $4 $5 }')
[ -z "$date" ] && echo "$file" >> ~/error.txt && continue

#example: Image timestamp : 2011:04:16 14:11:11

year=${date:0:4}

monthname=(ZERO January February March April May June July August September Octomber November December)
month=${monthname[10#${date:5:2}]}
monthn=${date:5:2}

day=${date:8:2}

hour=${date:10:2}
min=${date:13:2}
sec=${date:16:2}

mkdir -p "${target}/${year}"

n=$(($RANDOM % 100 + 1))

mv "$file" "${target}/${year}/${day} - ${month} - ${year}_${hour}.${min}.${sec}_$n.nef"

done


#delete all @eaDir and empty folder
find "$source" -type d  -name "@eaDir" -print0 |xargs -0 rm -rf
if [ ! -e "$source/".nodeletefolder ] ; then
    touch "$source/".nodeletefolder
fi

find "$source/" -empty -type d -exec rmdir {} +
