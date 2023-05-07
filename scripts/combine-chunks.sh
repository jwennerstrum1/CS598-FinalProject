#!/bin/zsh
# In order to combine chunks, make sure that all chunk files reside in
# a directory named outputchunks_<i>, where "i" is the iteration of
# running quickUMLS_getCUI.py.  For example, the directory structure
# could look like the following:
#
# .../patient_trajectory_prediction/concept_annotation/data/
# ├── combineChunks
# │   └── combine-chunks.sh
# ├── outputchunks_1
# │   ├── 11.csv.output
# │   ├── 23.csv.output
# │   └── 47.csv.output
# ├── outputchunks_2
# │   ├── 23.csv.output
# │   ├── 43.csv.output
# │   └── 47.csv.output
# └── outputchunks_3
#     ├── 23.csv.output
#     └── 43.csv.output# 
#
# In the "combineChunks" directory, this will pull in all of the csv
# file and concatenate them in descending order based on the suffix of
# the folder name

count=1
sortedDirs=$(ls -d ../outputchunks_* | sort) 

read -d'\n' -A dirsArray <<< $sortedDirs
for dir in $dirsArray
do
    echo $dir:
    for file in $dir/*.csv.output
    do
        echo "  $file"
        fileName=$(echo $file | cut -d'/' -f3)
        echo "    $fileName"
        cat $file >> $fileName
    done
    count=$(( count+1 ))
done

