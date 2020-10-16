#!/bin/bash
#Author: Dawid Dziembor

pattern=$1
ext1=$2
ext2=$3
dir1=$4
dir2=$5

for file in $dir1/*
do
   if [ -f $file ]
   then
      f_name=${file%.*} #Remove all chars from end to first .
      f_name=${f_name##*/} #Remove all chars from start to last /
      f_ext=${file##*.} #Remove all chars from start to last .
      if [[ $f_name == *"$pattern"* ]]
      then
         if [[ ".$f_ext" == "$ext1" ]]
         then
            cp $f_name$ext1 $f_name$ext2
            mv $f_name$ext2 $dir2
         fi
      fi
   fi
done


