#!/bin/bash
# Author: Dawid Dziembor
# Some rights reserved
pattern=$1
ext1=$2
ext2=$3
dir1=$4
dir2=$5

# Errors
if [ "$#" -le 4 ]; then
    printf "\nMissing arguments, should be: \n\n"
    printf "$0 pattern .ext1 .ext2 dir1 dir2 \n\n"
    exit 2
fi

if [ "$#" -gt 5 ]; then
    printf "\nToo much arguments, should be: \n\n"
    printf "$0 pattern .ext1 .ext2 dir1 dir2 \n\n"
    exit 2
fi

# argument 2 and 3 should be with .
# TODO
# dir 2 should be existing directory
# source directory: execute and read permission
# source file: read permission.
# target directory: execute and write permission.



doit(){
local directory=$1
local file
for file in "$directory"/*
do
   if [ -d $file ]
   then
      doit "$file"
   fi
   
   if [ -f $file ]
   then
      f_name=${file%.*} # Remove all chars from end to first . (with .)
      f_name=${f_name##*/} # Remove all chars from start to last /
      f_ext=${file##*.} # Remove all chars from start to last . (with .)
      if [[ "$f_name" == *"$pattern"* ]]
      then
         if [[ ".$f_ext" == "$ext1" ]]
         then
            cp "$directory"/$f_name$ext1 $dir2/$f_name$ext2
         fi
      fi
   fi
done
}
doit "$dir1"
