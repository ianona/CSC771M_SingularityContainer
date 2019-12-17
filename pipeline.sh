echo "Reference: $3"
echo "Query: $4"

echo "Sequence Aligner: $1"

if [ $1 = "last" ]
then
#!/bin/bash
#echo Bam file name is: $bam_name

sudo lastdb hivdb_bash $3 #hxb2.fasta
echo "Train scoring scheme"
sudo last-train hivdb_bash -Q1 $4
echo "Lastdb command done."
sudo lastal hivdb_bash -Q1 $4 | last-map-probs  > hivalns_bash.maf #sample_1million.fastq.gz > hivalns_bash.maf
echo "Maf file created."
maf-convert sam hivalns_bash.maf > hivalns.sam
samtools view -bT $ref hivalns.sam > hivalns.bam #hxb2.fasta hivalns.sam > hivalns.bam
echo "Convert maf to sam/bam"
samtools sort hivalns.bam -o sortednewSample1mil.bam #$bam_name  # hivalns.sorted.bam
echo "Bam sorted."
fi

if [ $1 = "bowtie" ]
then
echo "$3"
echo "$4"
echo "Indexing .fasta string."
sudo bowtie2-build $3 hxb2-1mil-index
echo "Indexed .fasta file."
sudo bowtie2 --very-sensitive-local -x hxb2-1mil-index -U $4 -S newSample1mil.sam
echo "Performed alignment, generated .sam file."
sudo samtools view -bS newSample1mil.sam > newSample1mil.bam
echo "Converted .sam file to .bam file."
sudo samtools sort newSample1mil.bam -o sortednewSample1mil.bam
echo "Generated sorted .bam file"
fi

echo "Variant Caller: $2"

if [ $2 = "lofreq" ]
then
CURRENTEPOCTIME=`date +"%Y-%m-%d%T"`
OUTPUT="variants_${CURRENTEPOCTIME}.vcf"
echo Reference is: $3
echo Query is: $4
echo Outputting to: $OUTPUT
echo Running Lofreq...
lofreq call -f $3 -o $OUTPUT $4
fi

if [ $2 = "virvarseq" ]
echo "VirVarSeq not functional..."
then
fi
