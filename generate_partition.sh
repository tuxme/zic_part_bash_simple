#!/bin/bash


FILE=$1
FILE_NAME=`basename $FILE`
DATE=`date +%Y%m%d%H%M%S`

TMP_DIR="/tmp/PART_${DATE}"

mkdir $TMP_DIR
CPT=1
echo "Generation Notes"
while read NOTE
	do
		composite -compose Over ORIG/${NOTE}.png ORIG/porte.png $TMP_DIR/${CPT}.png
		CPT=$((CPT + 1))
	done < $FILE

echo "Generation de la partition"

cp ORIG/porte.png $TMP_DIR/${FILE_NAME}.png
CPT_CREA=1
MAX_LINE=7

LINE_CREATE=1
CPT_MAX_LINE=1
LINE=1
cp ORIG/porte.png $TMP_DIR/${FILE_NAME}_${CPT_MAX_LINE}.png

while [[ "$CPT_CREA" != "$CPT" ]]
	do
		if [[ "${CPT_MAX_LINE}" == "$MAX_LINE" ]]
			then
				CPT_MAX_LINE=1
				LINE_CREATE=$((LINE_CREATE +1))
				cp ORIG/porte.png $TMP_DIR/${FILE_NAME}_${LINE_CREATE}.png
				LINE=$((LINE + 1))
			else
				
				montage  -geometry +1+1 $TMP_DIR/${FILE_NAME}_${LINE}.png $TMP_DIR/${CPT_CREA}.png $TMP_DIR/${FILE_NAME}_${LINE}.png
				CPT_MAX_LINE=$((CPT_MAX_LINE+1))
				CPT_CREA=$(($CPT_CREA + 1))	
			fi
	done

LINE_CPT=2
cp $TMP_DIR/${FILE_NAME}_1.png $TMP_DIR/${FILE_NAME}_FINAL.png
while [[ $LINE_CPT -le $LINE ]]
	do
		echo "$LINE_CPT $LINE " 
		convert -append  $TMP_DIR/${FILE_NAME}_FINAL.png $TMP_DIR/${FILE_NAME}_${LINE_CPT}.png $TMP_DIR/${FILE_NAME}_FINAL.png
		LINE_CPT=$((LINE_CPT+1))
	done
cp $TMP_DIR/${FILE_NAME}_FINAL.png ${FILE}_generated_partition.png
rm -Rf  $TMP_DIR/

echo "La partition générée se trouve : ${FILE}_generated_partition.png"

