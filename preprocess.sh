#!/bin/bash

cd CSV;
recode -f cp1250..utf8 *csv

cat *csv | cut -d ";" -f 3 | uniq | grep -v "^Název obce" | sort | uniq > cities
cat *csv | cut -d ";" -f 9 | uniq | grep -v "^Název části obce" | sort | uniq > city_parts
cat *csv | cut -d ";" -f 11 | uniq | grep -v "^Název ulice" | sort | uniq > streets
cat *csv | cut -d ";" -f 16 | uniq | grep -v "^PSČ" | sort | uniq > postcodes
cat *csv | cut -d ";" -f 1,3,9,11,12,13,14,15,16 | grep -v "^Kód ADM;" > addresses
cat *csv | cut -d ";" -f 1,17,18 | grep -v "^Kód ADM;" > coords
