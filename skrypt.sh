#!/bin/bash
# Author: Dawid Dziembor
# Some rights reserved

###########################
# Start of error handling #
###########################
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

if [[ "$2" != .* ]]; then
    printf "\nFirst extension should start with . character look at: \n\n"
    printf "$0 pattern \e[4m.ext1\e[0m .ext2 dir1 dir2 \n\n"
    exit 2
fi

if [[ "$3" != .* ]]; then
    printf "\nSecond extension should start with . character, look at: \n\n"
    printf "$0 pattern .ext1 \e[4m.ext2\e[0m  dir1 dir2 \n\n"
    exit 2
fi

if [[ ! -e $4 ]]; then
    printf "\nSource directory doesn't exist, look at: \n\n"
    printf "$0 pattern .ext1 .ext2 \e[4m.dir1\e[0m dir2 \n\n"
    exit 2
fi

if [[ ! -e $5 ]]; then
    printf "\nDestination directory doesn't exist: \n\n"
    printf "To create directory use: mkdir $5 \n\n"
    exit 2
fi

if [[ ! -x $4 ]]; then
    printf "\nYou have no execute permission in source directory $4: \n\n"
    printf "To add execute permission use: chmod +x $4  \n\n"
    exit 2
fi

if [[ ! -x $5 ]]; then
    printf "\nYou have no execute permission in desination directory $5: \n\n"
    printf "To add execute permission use: chmod +x $5  \n\n"
    exit 2
fi

if [[ ! -r $4 ]]; then
    printf "\nYou have no read permission in source directory $4: \n\n"
    printf "To add read permission use: chmod +r $4  \n\n"
    exit 2
fi

if [[ ! -w $5 ]]; then
    printf "\nYou have no write permission in destination directory $5: \n\n"
    printf "To add read permission use: chmod +r $5  \n\n"
    exit 2
fi
##########################
# End of error handling  #
##########################


##############################
# Start of variable renaming #
##############################

PATTERN=$1
SRC_EXT=$2
DEST_EXT=$3
SRC_DIR=$4
DEST_DIR=$5

############################
# End of variable renaming #
############################

find_and_copy(){
local directory=$1
local file
for file in "$directory"/*
do
   if [ -d "$file" ]; then
      find_and_copy "$file"
   fi
   
   if [ -f "$file" ]; then
      f_name=${file%.*} # Remove all chars from end to first . (with .)
      f_name=${f_name##*/} # Remove all chars from start to last /
      f_ext=.${file##*.} # Remove all chars from start to last . (with .)
      if [[ "$f_name" == *"$PATTERN"* ]]; then
         if [[ "$f_ext" == "$SRC_EXT" ]]; then
            if [[ ! -r "$directory"/$f_name$SRC_EXT ]]; then
               printf "\e[31m Missing read permission in \e[0m "$directory"/$f_name$SRC_EXT \n"
            else
            cp "$directory"/$f_name$SRC_EXT "$DEST_DIR"/$f_name$DEST_EXT
            printf "\e[32m Copied\e[0m $directory/$f_name$SRC_EXT to $DEST_DIR/$f_name$DEST_EXT \n"
            fi
         fi
      fi
   fi
done
}

find_and_copy "$SRC_DIR"

