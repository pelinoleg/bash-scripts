#!/bin/bash

source="/volume1/Dropbox/Camera Uploads"
target="/volume1/Dropbox/Video/Temp Video"
target_photo="/volume1/Dropbox/Photo/From mobile"


find "$source" -type f -iname "*.jpg" | while read file ; do
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

mkdir -p "${target_photo}/${year}"
#mkdir -p "${target_photo}/${year}/${monthn} ${month}"

n=$(($RANDOM % 100 + 1))

mv "$file" "${target_photo}/${year}/${day} - ${month} - ${year}_${hour}.${min}.${sec}_$n.jpg"

done


find "$source"  -type f -name "*.mp4" | 
 while IFS= read -r file; do
    ## Get the file's modification year
    year="$(date -d "$(stat -c %y "$file")" +%Y)"
    ## Get the file's modification month
    month="$(date -d "$(stat -c %y "$file")" +%B)"
    monthn="$(date -d "$(stat -c %y "$file")" +%m)"
    day="$(date -d "$(stat -c %y "$file")" +%d)"
    hour="$(date -d "$(stat -c %y "$file")" +%H)"
    min="$(date -d "$(stat -c %y "$file")" +%M)"
    sec="$(date -d "$(stat -c %y "$file")" +%S)"

    ## Create the directories if they don't exist. The -p flag
    ## makes 'mkdir' create the parent directories as needed so
    ## you don't need to create $year explicitly.
    [[ ! -d "$target/$year/$monthn - $month" ]] && mkdir -p "$target/$year/$monthn - $month"; 

    ## Move the file
    mv "$file" "$target/$year/$monthn - $month/$day - $month - $year _ $hour-$min-$sec.mp4"
done


find "$source"  -type f -name "*.mov" | 
 while IFS= read -r file; do
    ## Get the file's modification year
    year="$(date -d "$(stat -c %y "$file")" +%Y)"
    ## Get the file's modification month
    month="$(date -d "$(stat -c %y "$file")" +%B)"
    monthn="$(date -d "$(stat -c %y "$file")" +%m)"
    day="$(date -d "$(stat -c %y "$file")" +%d)"
    hour="$(date -d "$(stat -c %y "$file")" +%T)"

    ## Create the directories if they don't exist. The -p flag
    ## makes 'mkdir' create the parent directories as needed so
    ## you don't need to create $year explicitly.
    [[ ! -d "$target/$year/$monthn - $month" ]] && mkdir -p "$target/$year/$monthn - $month"; 

    ## Move the file
    mv "$file" "$target/$year/$monthn - $month/$day - $month - $year_$hour.mov"
done

#copy all jpg without date
mkdir -p "${target_photo}/no_date"
find "$source" -not -path "*@eaDir*" -type f -iname "*.jpg" -exec mv {}  "${target_photo}/no_date" \;

#copy all gif (if exists)
mkdir -p "${target_photo}/gif"
find "$source" -not -path "*@eaDir*" -type f -iname "*.gif" -exec mv {}  "${target_photo}/gif" \;


#copy all gif (if exists)
mkdir -p "${target_photo}/png"
find "$source" -not -path "*@eaDir*" -type f -iname "*.png" -exec mv {}  "${target_photo}/png" \;


#delete all @eaDir and empty folder
find "$source" -type d  -name "@eaDir" -print0 |xargs -0 rm -rf
if [ ! -e "$source/".nodeletefolder ] ; then
    touch "$source/".nodeletefolder
fi

find "$source/" -empty -type d -exec rmdir {} +


