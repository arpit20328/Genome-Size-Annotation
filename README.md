# Genome-Size-Annotation
Scripts to Download Genome Size from NCBI Server 

Metagenomics Analysis often require genome size to calculate abundance estimation. for eg a normalized abundance is calculate on the concept of depth of coverage which is essentially total amount of assigned reads to a taxa divided by taxa sequence length. 

In pipelines such as bowtie2 there is already presenece of genome size in the output but in many cases like kraken/kraken2 and kaiju based classifications there is no mention of genome size of taxa classified, rather only reads assigned are mentioned. Hence to calculate depth of coverage as parameter of abundance estimation we need genome size. 

One way is to calculate genomes size from the .fasta or .fna files present in the taxonomy folder like in kraken/kraken2, but these databaseses are often old and NCBI continously updates genome sizes of the species concerned, so it is in the best interest to calculate/fetch latest genome sizes from NCBI server. 

Secondly in classification algorithms like kaiju, there is no .fna or .fasta file available rather only index files are available from where the alignement is done and we get reads assigned table as output species wise. There we even do not have an option to fetch genome sizes at all. 

We devloped bash scripts to download genome size directly from NCBI server provided we have taxid list available with us. The only limitation is that some species/taxa which have assigned taxid via NCBI but do not have defined genome do not give genome size from our devloped scripts. For these cases we take help of data minning from AI tools like perplexity.com to fetch genome sizes with mentioning of the sources/research papers/portal which mentions it. 


![image](https://github.com/user-attachments/assets/ebd59d18-04ea-49eb-a8ec-a76724512f4f)



