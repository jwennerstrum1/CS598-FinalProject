# CS598-FinalProject
## Quick UMLS Processing

Scripts to facilitate with the UMLS processing are contained within the `scripts` directory.  This includes:
- `print-status.sh`: Prints the status of file processing during an iteration of `quickUMLS_getCUI.py`.
- `create-checkpoint.sh`: To prevent re-processing the same lines from the clinicial notes files, this file will split the input `csv` file based on the most recently processed row. It will create new `csv` files which should be moved into the `chunkssmall` directory before subsequent runs of `quickUMLS_getCUI.py`.
- `combine-chunks.sh`: Combines several partially processed files into a single `*.csv.output` file.  This should be run after processing all of the `*.csv` files and before `quickumls_processing.py` in step 2.5 of the original author's [repository](https://github.com/JamilProg/patient_trajectory_prediction/).

