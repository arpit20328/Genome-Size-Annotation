#!/bin/bash
mkdir  genome_annotation_by_arpit
cd genome_annotation_by_arpit
#Make your tsv file, free of special characters and spaces via following command
sed 's/[^a-zA-Z0-9\t]//g' file.tsv > temp.tsv && mv temp.tsv file.tsv
awk '{print $1}' file.tsv  | while read taxon_id; do datasets summary genome taxon $taxon_id --reference > taxon_$taxon_id.txt; done
#Above command will give output files like taxon_573.txt  etc which will contain genome summary for that taxon 
#some output files will have 0 byte size 
#some output files will have 19 byte size
mkdir -p files_having_zero_or_19_byte_size
# Find and copy files that have sizes of either 0 or 19 bytes
find . -type f -name 'taxon_*.txt' \( -size 0c -o -size 19c \) -exec mv {} files_having_zero_or_19_byte_size/ \;
cd files_having_zero_or_19_byte_size
ls taxon_*.txt | sed -e 's/taxon_//' -e 's/.txt//' > extracted_numbers.tsv
#Make your tsv file, free of special characters and spaces via following command
sed 's/[^a-zA-Z0-9\t]//g' extracted_numbers.tsv > temp.tsv && mv temp.tsv extracted_numbers.tsv
awk '{print $1}' extracted_numbers.tsv  | while read taxon_id; do datasets summary genome taxon $taxon_id > taxon_$taxon_id.txt; done
mkdir  files_size_less_than_3k_bytes
find $PWD -type f -name "*.txt" -size -3k -exec mv {} $PWD/files_size_less_than_3k_bytes/ \;
cd files_size_less_than_3k_bytes
#another round to make these sizes are not extractable 
ls taxon_*.txt | sed -e 's/taxon_//' -e 's/.txt//' > extracted_numbers.tsv
#Make your tsv file, free of special characters and spaces via following command
sed 's/[^a-zA-Z0-9\t]//g' extracted_numbers.tsv > temp.tsv && mv temp.tsv extracted_numbers.tsv
awk '{print $1}' extracted_numbers.tsv  | while read taxon_id; do datasets summary genome taxon $taxon_id > taxon_$taxon_id.txt; done
find $PWD -type f -name "*.txt" -size +3k -exec mv {} /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/  \;
cd /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/
cp *.txt  /home/arpit20328/bracken_genome_size_estimations/
cd /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/
mkdir seq_lengths
find $PWD -maxdepth 1 -name "*.txt" -exec bash -c 'grep -Eo "\"total_sequence_length\":\"[0-9]+\"" "$1" | sed "s/\"total_sequence_length\":\"\([0-9]\+\)\"/\1/" > $PWD/seq_lengths/seq_length_$(basename "$1")' _ {} \;
cd seq_lengths
for file in $PWD/seq_length_taxon_*.txt; do avg=$(awk '{s+=$1} END {print s/NR}' "$file"); echo "average: $avg" >> "$file"; done
cd   /home/arpit20328/bracken_genome_size_estimations/
mkdir seq_lengths
find $PWD -maxdepth 1 -name "*.txt" -exec bash -c 'grep -Eo "\"total_sequence_length\":\"[0-9]+\"" "$1" | sed "s/\"total_sequence_length\":\"\([0-9]\+\)\"/\1/" > $PWD/seq_lengths/seq_length_$(basename "$1")' _ {} \;
cd  seq_lengths
for file in $PWD/seq_length_taxon_*.txt; do avg=$(awk '{s+=$1} END {print s/NR}' "$file"); echo "average: $avg" >> "$file"; done
echo -e "Taxon\tAverage" > Seq_lengths_1.tsv; for file in $PWD/seq_length_taxon_*.txt; do taxon=$(basename "$file" | sed 's/seq_length_taxon_//;s/.txt//'); avg=$(awk '/average:/ {print $2}' "$file"); echo -e "$taxon\t$avg" >> Seq_lengths_1.tsv; done
cd  /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths
echo -e "Taxon\tAverage" > Seq_lengths_1.tsv; for file in $PWD/seq_length_taxon_*.txt; do taxon=$(basename "$file" | sed 's/seq_length_taxon_//;s/.txt//'); avg=$(awk '/average:/ {print $2}' "$file"); echo -e "$taxon\t$avg" >> Seq_lengths_2.tsv; done


cat /home/arpit20328/bracken_genome_size_estimations/seq_lengths/taxon_seq_lengths_1.tsv    /home/arpit20328/bracken_genome_size_estimations/files_having_zero_or_19_byte_size/seq_lengths/taxon_seq_lengths_2.tsv  > /home/arpit20328/bracken_genome_size_estimations/taxon_seq_length_1_2.tsv


