#!/bin/bash

# Define the fasta file
fasta_file="your_fasta_file.fasta"

# Initialize variables
header=""
sequence=""

# Read through the fasta file
while read -r line; do
    if [[ $line == ">"* ]]; then
        # If we reach a new header and sequence isn't empty, calculate the genome size
        if [[ -n $sequence ]]; then
            genome_size=$(echo -n "$sequence" | wc -c)
            echo "$header : $genome_size"
        fi
        # Set the new header (removing the '>')
        header=$(echo "$line" | sed 's/>//')
        # Reset the sequence for the next entry
        sequence=""
    else
        # Append the line to the sequence
        sequence+="$line"
    fi
done < "$fasta_file"

# After the loop, print the last entry
if [[ -n $sequence ]]; then
    genome_size=$(echo -n "$sequence" | wc -c)
    echo "$header : $genome_size"
fi
