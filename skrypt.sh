#!/bin/bash
#Author: Dawid Dziembor

pattern=$1
ext1=$2
ext2=$3
dir1=$4
dir2=$5

#arguments:
#$1 current file name
#$2 name pattern
#$3 current file extension
#$4 extension pattern
#$5 destination extension pattern
#$6 destination directory
check_pattern (){
   if [[ $1 == *"$2"* ]]
   then
      if [[ ".$3" == "$4" ]]
      then
         cp $1\.$3 $1$5
         mv $1$5 $6
      fi
   fi
}

#lists of all normal files with regex pattern
for file in $dir1/*
do
   if [ -f $file ]
   then
      f_name=${file%.*} #Sh Parameter Expansion - all chars to '.'
      f_name=${f_name##*/} #Sh Parameter Expansion
      f_ext=${file##*.} #Sh Parameter Expansion - chars without those before '.'
      check_pattern $f_name $pattern $f_ext $ext1 $ext2 $dir2
   fi
done


