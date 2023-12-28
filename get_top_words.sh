#!/bin/bash
#Violeta Solorio
#10/14/2023
#Assigment 1, part A
#The get_top_words.sh scrip takes in a file and a variable. The file is read and the top K words are printed out

sample=$1
k=$2
awk '{ for(i=1; i<=NF; i++) print $i}' $sample > words.txt #Words get printed into their own lines
awk '{for(i=1; i<=NR; i++) print tolower($i)}' words.txt > lowercase.txt

grep -v -w -f stopwords.txt lowercase.txt > cleared.txt 
#The words in stopwords are compared agaisnt lowercase.txt --> words not found in stopwords are written in cleared.txt

#Words are sorted, freq is counted along with uniqueness, punctation is removed
#sorted again numerically then alpha.. , result is printed into a new file
sort cleared.txt | uniq -c | tr -d '[:punct:]' | sort -k1,1nr -k2 | awk '{if (NF >=2) printf "%s %s\n", $1, $2}' > unique.txt 
head -n $k unique.txt | awk '{print $2}' 

