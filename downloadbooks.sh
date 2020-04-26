#!/bin/bash
#Author: Prasoon Kunj
#Description: Download ebooks from springer
#Usage: provide URL in argument
#Example: bash downloadbooks.sh "http://link.springer.com/openurl?genre=book&isbn=978-0-306-48048-5"
#run excute.sh to download more that 400 ebooks
wget "$1"
start=`grep "canonical" openurl*|awk -F'"' '$0=$4'|awk -F'/' '{print $5}'`
end=`grep "canonical" openurl*|awk -F'"' '$0=$4'|awk -F'/' '{print $6}'`
link=`echo "$start"%2F"$end".pdf`
name=`grep "<title>" openurl*|awk -F '>' '{print $2}'|awk -F'|' '{print $1}'`
echo "Downloading $name ........."
wget "https://link.springer.com/content/pdf/$link"
mv "$start"%2F"$end".pdf "$name.pdf"
if [ -d "books" ];then
  mv *.pdf books
else
  mkdir ebooks
  mv *.pdf books
fi
rm -r openurl*
