#! /bin/bash

writeTestResult (){
	filename="result$1.txt" 
	echo "$2;$3" >> $filename
}

clearResultFile(){
	filename="result$1.txt"
	> $filename
}

clearResultFile Lab11
writeTestResult Lab11 59090002 20
