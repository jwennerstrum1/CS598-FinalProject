# Print the status of the UMLS processing. This script prints the
# status of parsing a source csv file in the following format:
# $> print-status
#    1.csv     58%
#    45.csv    48%
#    32.csv    98%
#    ...

pathToSourceChunks="/Users/jack/Documents/notes/UIUC/patient_trajectory_prediction/concept_annotation/data/chunkssmall/"
pathToParsedChunks="/Users/jack/Documents/notes/UIUC/patient_trajectory_prediction/concept_annotation/data/outputchunkssmall/"

for file in $pathToSourceChunks*
do

    line_count=$(wc -l $file | cut -d" " -f 3)
    if [[ -z $line_count ]]
    then
        line_count=$(wc -l $file | cut -d" " -f 4)
    fi
    if [[ -z $line_count ]]
    then
        line_count=$(wc -l $file | cut -d" " -f 5)
    fi
    
    sourceChunkFileName=$(echo $file | cut -d"/" -f11)
    fileName="${pathToParsedChunks}${sourceChunkFileName}.output"
    if [[ -s $fileName ]]
    then    
        last_record=$(rg -e "^[1-9]" $fileName | tail -n 1 | cut -d"," -f1-5)
        split_loc_plus_one=$(rg -n -e "$last_record" "${file}" | tail -n 1 | cut -d":" -f1)
        split_loc=$(( split_loc_plus_one-1))
        percentage_done=$((split_loc * 100 / line_count))
        echo "$sourceChunkFileName:\t $percentage_done%"
    else
        echo "${sourceChunkFileName}:\t 0%"
    fi
done
