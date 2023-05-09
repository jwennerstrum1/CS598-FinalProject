# CS598-FinalProject
## Background
Our Final Project replicates the work of Zaghir et al in the paper [https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8982755/](Real-world Patient Trajectory Prediction from Clinical Notes Using Artificial Neural Networks and UMLS-Based Extraction of Concepts). The source code for the original author's work can be found at the following link:
https://github.com/JamilProg/patient_trajectory_prediction/

## Quick UMLS Processing

Scripts to facilitate with the UMLS processing are contained within the `scripts` directory.  This includes:
- `print-status.sh`: Prints the status of file processing during an iteration of `quickUMLS_getCUI.py`.
- `create-checkpoint.sh`: To prevent re-processing the same lines from the clinicial notes files, this file will split the input `csv` file based on the most recently processed row. It will create new `csv` files which should be moved into the `chunkssmall` directory before subsequent runs of `quickUMLS_getCUI.py`.
- `combine-chunks.sh`: Combines several partially processed files into a single `*.csv.output` file.  This should be run after processing all of the `*.csv` files and before `quickumls_processing.py` in step 2.5 of the original author's [repository](https://github.com/JamilProg/patient_trajectory_prediction/).

## Mortality Prediction
We experiment with the target task of mortality prediction in the `RunMortalityPrediction.ipynb` notebook.  This notebook creates several combinations of hyperparameter settings and passes them to the author's mortality prediction function.  Since model training requires an available GPU, my partner and I ran this script in Google Colab.

## Diagnosis Prediction
We experiment with the target task of mortality prediction in the `RunDiagnosisPrediction.ipynb` notebook.  This notebook contains a similar script as `RunMortalityPrediction.ipynb` with different hyperparameters. This task was found to be significantly more computationally expensive and a computer with 30 GB of RAM and a GPU with 15 GB of ram is recommended.  We found that using Google Colab Pro was sufficient.
