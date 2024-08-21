# Genome-Size-Annotation
# Script is Written by Mr Arpit Mathur, who at the time of devloping is working at Dr Nikhil Patkar's lab at ACTREC, Tata Memorial Center, Navi Mumbai
# Queries can be directed in the issues section. 


Scripts to Download Genome Size from NCBI Server 

Metagenomics Analysis often require genome size to calculate abundance estimation. for eg a normalized abundance is calculate on the concept of depth of coverage which is essentially total amount of assigned reads to a taxa divided by taxa sequence length. 

In pipelines such as bowtie2 there is already presenece of genome size in the output but in many cases like kraken/kraken2 and kaiju based classifications there is no mention of genome size of taxa classified, rather only reads assigned are mentioned. Hence to calculate depth of coverage as parameter of abundance estimation we need genome size. 

One way is to calculate genomes size from the .fasta or .fna files present in the taxonomy folder. But in metagenomic pipelines like kraken/kraken2, classification is done towards/directed towards a clade and not to all strains/sub species. Hence genome size estimation of the clade become a challenge since there is no said rule on how to calculate estimated genome length of clade when genome size of sub species / strains is given. Hence even though fasta file of the kraken2 taxonomy contains genome size information, it is in the best interest to calculate genome size of clade itself. Altough we have provided script to calculate genome size of each species present in the fasta file.  

Secondly in classification algorithms like kaiju, there is no .fna or .fasta file available rather only index files are available from where the alignement is done and we get reads assigned table as output species wise. There we even do not have an option to fetch genome sizes at all. 

We devloped bash scripts to download genome size directly from NCBI server provided we have taxid list available with us. The only limitation is that some species/taxa which have assigned taxid via NCBI but do not have defined genome do not give genome size from our devloped scripts. For these cases we take help of data minning from Genome Check API tool from NCBI (https://api.ncbi.nlm.nih.gov/genome/v0/expected_genome_size?species_taxid=<taxid>).  

Some taxid still will not be having expected genome size in Genome Check NCBI API.  For these cases we took help of AI tools like perplexity.com to fetch genome sizes with mentioning of the sources/research papers/portal which mentions it. Our curated database mentions source of the information from where genome size is extracted. 


![image](https://github.com/user-attachments/assets/a2733c74-9544-4b5d-841a-f0459022a865)


![image](https://github.com/user-attachments/assets/6006f78e-6af2-4149-b5b9-9fe946b66426)


![image](https://github.com/user-attachments/assets/53bea1d8-2dc5-4332-a2e9-8e9657c92e8c)

![image](https://github.com/user-attachments/assets/2756722f-a0f6-4285-8938-27d3745bb8f2)

![image](https://github.com/user-attachments/assets/fc948580-827a-47e4-8e85-084b1e2cea7d)

![image](https://github.com/user-attachments/assets/3723aff3-d0aa-4ba2-9fdf-0fbdd65d292c)

