import pandas as pd
import os

# Set the chunk size in MB
chunk_size_mb = 50

# Set the input file path
input_file_path = 'path/to/input_file.csv'

# Set the output directory path
output_dir_path = 'path/to/output_dir/'

# Create the output directory if it doesn't exist
os.makedirs(output_dir_path, exist_ok=True)

# Get the size of the input file in bytes
input_file_size = os.path.getsize(input_file_path)

# Calculate the number of chunks based on the chunk size in MB
chunk_size_bytes = chunk_size_mb * 1024 * 1024
num_chunks = input_file_size // chunk_size_bytes + 1

# Read the input file in chunks and save each chunk to a separate file
for i, chunk in enumerate(pd.read_csv(input_file_path, chunksize=chunk_size_bytes)):
    output_file_path = os.path.join(output_dir_path, f'{i+1}.csv')
    chunk.to_csv(output_file_path, index=False)