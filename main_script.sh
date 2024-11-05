#!/bin/bash

mkdir  genome_annotation_by_arpit

cd genome_annotation_by_arpit


#Make your tsv file, free of special characters and spaces via following command
sed 's/[^a-zA-Z0-9\t]//g' file.tsv > temp.tsv && mv temp.tsv file.tsv


awk '{print $1}' file.tsv  | while read taxon_id; do datasets summary genome taxon $taxon_id --reference > taxon_$taxon_id.txt; done



#Above command will give output files like taxon_573.txt  etc which will contain genome summary for that taxon 

#some output files will have 0 byte size 
#some output files will have 19 byte size


# Define the destination directory
destination="/home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size"

# Create the destination directory if it doesn't exist
mkdir -p "$destination"

# Find and copy files that have sizes of either 0 or 19 bytes
find . -type f -name 'taxon_*.txt' \( -size 0c -o -size 19c \) -exec mv {} "$destination" \;

echo "Files with size 0 or 19 bytes have been copied to $destination"



cd "$destination"

ls taxon_*.txt | sed -e 's/taxon_//' -e 's/.txt//' > extracted_numbers.tsv

#Make your tsv file, free of special characters and spaces via following command
sed 's/[^a-zA-Z0-9\t]//g' extracted_numbers.tsv > temp.tsv && mv temp.tsv extracted_numbers.tsv
 
awk '{print $1}' extracted_numbers.tsv  | while read taxon_id; do datasets summary genome taxon $taxon_id > taxon_$taxon_id.txt; done

mkdir  "$destination/files_size_less_than_3k_bytes

find $PWD -type f -name "*.txt" -size -3k -exec mv {} files_size_less_than_3k_byte/ \;

cd   $destination/files_size_less_than_3k_bytes

#another round to make these sizes are not extractable 


cd  /home/arpit20328/files_having_zero_or_19_byte_size/files_size_less_than_3k_bytes && ls taxon_*.txt | sed -e 's/taxon_//' -e 's/.txt//' > extracted_numbers.tsv

awk '{print $1}' extracted_numbers.tsv  | while read taxon_id; do datasets summary genome taxon $taxon_id > taxon_$taxon_id.txt; done



find /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/files_size_less_than_3_byte -type f -name "*.txt" -size +3k -exec mv {} /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/  \;


cd /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/


cp *.txt  /home/arpit20328/bracken_genome_size_estimations/

cd /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/

mkdir seq_lengths

find /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/ -maxdepth 1 -name "*.txt" -exec bash -c 'grep -Eo "\"total_sequence_length\":\"[0-9]+\"" "$1" | sed "s/\"total_sequence_length\":\"\([0-9]\+\)\"/\1/" > /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths/seq_length_$(basename "$1")' _ {} \;


cd seq_lengths

for file in /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths/*.txt; do \
    avg=$(awk '{s+=$1} END {print s/NR}' "$file"); \
    echo "average:$avg" >> "$file"; \
done
 

cd   /home/arpit20328/bracken_genome_size_estimations/


mkdir seq_lengths

find /home/arpit20328/bracken_genome_size_estimations/ -maxdepth 1 -name "*.txt" -exec bash -c 'grep -Eo "\"total_sequence_length\":\"[0-9]+\"" "$1" | sed "s/\"total_sequence_length\":\"\([0-9]\+\)\"/\1/" > /home/arpit20328/bracken_genome_size_estimations/seq_lengths/seq_length_$(basename "$1")' _ {} \;



cd  seq_lengths


 for file in /home/arpit20328/bracken_genome_size_estimations/seq_lengths/*.txt; do \
    avg=$(awk '{s+=$1} END {print s/NR}' "$file"); \
    echo "average:$avg" >> "$file"; \
 done

find /home/arpit20328/bracken_genome_size_estimations/seq_lengths/ -name "seq_length_taxon_*.txt" -exec bash -c 'taxid=$(basename "$1" .txt | sed "s/seq_length_taxon_//"); seq_length=$(grep -o "average:[0-9.e+-]*" "$1" | sed "s/average://"); echo -e "$taxid\t$seq_length"' _ {} \; > /home/arpit20328/bracken_genome_size_estimations/seq_lengths/taxon_seq_lengths_1.tsv



cd  /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths

 for file in  for file in /home/arpit20328/bracken_genome_size_estimations/seq_lengths/*.txt; do \
    avg=$(awk '{s+=$1} END {print s/NR}' "$file"); \
    echo "average:$avg" >> "$file"; \
 done



find /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths/ -name "seq_length_taxon_*.txt" -exec bash -c 'taxid=$(basename "$1" .txt | sed "s/seq_length_taxon_//"); seq_length=$(grep -o "average:[0-9.e+-]*" "$1" | sed "s/average://"); echo -e "$taxid\t$seq_length"' _ {} \; > /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths/taxon_seq_lengths_2.tsv

 
cat /home/arpit20328/bracken_genome_size_estimations/seq_lengths/taxon_seq_lengths_1.tsv    /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths/taxon_seq_lengths_2.tsv  > /home/arpit20328/bracken_genome_size_estimations/taxon_seq_length_1_2.tsv


