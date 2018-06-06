#!/bin/bash

PROJ='../data/GeneratedFiles'

#PROJ='../data/test'

# create header
echo -e 'ID\tChat' > ../data/merge_files.txt

for file in $PROJ/*
 do echo $file
 # create ID
 FILEID=$(basename $file .txt)
 # remove CRLF and \t in chats
 CONVO=$(cat $file | tr '\r\n\t' ' ')
 # merge all files
 echo -e "$FILEID\t$CONVO" >> ../data/merge_files.txt
done

# remove the first two characters
cat ../data/merge_files.txt | tr -d "\377\376" > ../data/merge_files2.txt

# probably not the best way to remove lines that contain non-english (Ascii) characters
LC_CTYPE=C awk '! /[^[:alnum:][:space:][:punct:]]/' ../data/merge_files2.txt \
> ../data/merge_files3.txt
