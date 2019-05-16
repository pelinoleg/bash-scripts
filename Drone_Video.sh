#!/bin/bash

source="/volume1/Dropbox/Sort Images/Drone Video"
target="/volume1/Dropbox/Video/Drone Video"


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

find "$source"  -type f -name "*.MP4" | 
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
    mv "$file" "$target/$year/$monthn - $month/$day - $month - $year _ $hour-$min-$sec.Mp4"
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


