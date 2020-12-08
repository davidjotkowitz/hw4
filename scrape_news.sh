#!/bin/bash

wget https://www.ynetnews.com/category/3082    #gets the html file

#scans the html file for article links, and puts out a sorted, 
#nonrepetitve list into lks.txt 
grep -E -o https://www.ynetnews.com/article/[[:alnum:]]{9} 3082|sort -u>lks.txt

#print out the number of links
cat lks.txt| wc -l>results.csv  

function searcher {
   while read line; do
     wget $line  
     name=${line: -9}  #extracts the name of the html file (last 9 digits)
     
     #x, y recieve the proper numbers for each prime minister
     x=$(grep -E -o Netanyahu $name |wc -l) 
     y=$(grep -E -o Gantz $name | wc -l)
 
     
     if (( (x>0) || (y>0) )); then
       echo "${line}, Netanyahu, ${x}, Gantz, ${y}">>results.csv
     else
       echo "${line}, -">>results.csv
     fi
   done
}

cat lks.txt|searcher
