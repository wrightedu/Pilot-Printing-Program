#!/bin/bash

# Takes a single paramter from the user, the path to a pilot zip dropbox download
# Extracts to /tmp and prints all files after creating and prepending a cover page
#
# Usage: printall ./pilotfile.zip

DATESTAMP=$(date +%h%d-%y-%H%M)
#UNIXTIMESTAMP=$(date +%s)
TMPDIR=/tmp/$DATESTAMP
PRINTER=UNIX_SECURE_PRINT

#if tmpdir exists, delete it
if [ -d $TMPDIR ]; then
  rm -rf $TMPDIR
fi

# check if provided file exists
if [ ! -f $1 ]; then 
  echo "$1 does not exist (needs to be a the zip file downloaded from pilot.)"
  break
fi

mkdir $TMPDIR
unzip $1 -d $TMPDIR
rm $TMPDIR/index.html


for i in $TMPDIR/*; do
  echo $i
  timestamp=$(echo $i | awk -F '-' '{print $6}')
  name=$(echo $i | awk -F '-' '{print $5}')
  echo "# Submission for $name
        ## Timestamp : $timestamp" > /tmp/tmpfile$DATESTAMP.md
  
  pandoc -s /tmp/tmpfile$DATESTAMP.md -f markdown+tex_math_dollars -o /tmp/pdf$DATESTAMP.pdf
  #pandoc -s /tmp/pdf$DATESTAMP.pdf "$TMPDIR/$i" -o /tmp/$name.pdf
  pdfunite /tmp/pdf$DATESTAMP.pdf "$i" /tmp/$DATESTAMP.pdf
  lp -d $PRINTER "/tmp/$DATESTAMP.pdf"

done

