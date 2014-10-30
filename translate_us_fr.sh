#!/bin/bash

FILE=$1
rm -f ${FILE}_translate_US_fr.txt

US_TAB[1]="C"
US_TAB[2]="D"
US_TAB[3]="E"
US_TAB[4]="F"
US_TAB[5]="G"
US_TAB[6]="A"
US_TAB[7]="B"

FR_TAB[1]="DO"
FR_TAB[2]="RE"
FR_TAB[3]="MI"
FR_TAB[4]="FA"
FR_TAB[5]="SOL"
FR_TAB[6]="LA"
FR_TAB[7]="SI"



while read line
	do
	for US in 1 2 3 4 5 6 7
		do
			if [[ $line == ${US_TAB[$US]}* ]] 
				then
					NOTE="${FR_TAB[$US]}`echo $line | sed "s#${US_TAB[$US]}##g"`" 
					echo $NOTE | tee -a ${FILE}_translate_US_fr.txt
			fi

	done
done < $FILE


echo "Fichier traduit : ${FILE}_translate_US_fr.txt"
