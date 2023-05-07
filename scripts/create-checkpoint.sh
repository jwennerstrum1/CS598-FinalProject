# Dependencies:
# - ripgrep: brew install ripgrep
#
# Run this script in another directory such as
# "concept_annotation/checkpointCreator" to ensure that you don't
# accidentally overwrite files.  This script will start by lookinq at
# what's in the "outputchunkpath" directory to see what files you've
# started processing. It will then copy the corresponding source files
# into the active directory. For example, if it finds 42.csv.output,
# 55.csv.output, and 68.csv.output in the output chunk directory, it
# will copy 42.csv, 55.csv, and 68.csv from the sourceFileDir
# directory into the current directory.

# It then tries to find the last line parsed from the csv file.  It
# does this by finding the last line starting with numbers. For
# example, if the last record in 42.csv.output looks like:
#   5101,6576,156170,2102-06-14,,,"discharge summary","report",,,"
#   C2095775
#   C0020517
#   C0014806
#   C0008947
# the last line detected will be:
#   5101,6576,156170,2102-06-14,,,"discharge summary","report",,,"
# It then uses the first few values in comma-delimeted string to
# search through the original 42.csv file to find the line number of
# this record.  Once we have the line number, n, we split the original
# file into chunks of size n, discard the first one, and concatenate
# the rest into a _new_ 42.csv file.
#
# The resulting *.csv files can moved into the chunkssmall directory
# and replace their predecessors.  These can be moved into the
# chunkssmall directory with:
#
# for file in *.csv
# do
# mv $file ../data/chunkssmall
# done            

#### TODO ######
# 1) change outputchunkpath to the location of the 'outputchunkssmall' directory
# 2) change sourceFileDir to the location of the 'chunkssmall' directory
outputchunkpath="/Users/jack/Documents/notes/UIUC/patient_trajectory_prediction/concept_annotation/data/outputchunkssmall/"
sourceFileDir="/Users/jack/Documents/notes/UIUC/patient_trajectory_prediction/concept_annotation/data/chunkssmall/"


count=1
for file in $outputchunkpath*.csv*
do
    if [[ $count -lt 200 ]]
    then
        echo "File = $file"
        if [[ -s $file ]];
        then
            outputFileName=$(echo $file | cut -d'/' -f11)
            echo "Output name $outputFileName found"
            fileName=$(echo $outputFileName | cut -d'.' -f1-2)
            echo "File name = $fileName"
            echo "Copying ${sourceFileDir}${fileName} into directory"
            cp "${sourceFileDir}${fileName}" .
            last_record=$(rg -e "^[1-9]" $file | tail -n 1 | cut -d"," -f1-5)
            echo "Last record3 is: $last_record"
            split_loc_plus_one=$(rg -n -e "$last_record" "${sourceFileDir}${fileName}" | tail -n 1 | cut -d":" -f1)
            echo "found splitpoint at location $split_loc_plus_one"
            split_loc=$((split_loc_plus_one-1))
            echo "breaking $fileName at location $split_loc"
            split -l $split_loc $fileName
            echo "removing xaa"
            rm xaa
            fileNum=$(echo $fileName | cut -d'.' -f1)
            cat x* > "${fileNum}.csv"
            rm x*
            count=$((count+1))
        else
            echo "File is empty, continuing..."
        fi
    else
        exit 0
    fi
done

         
