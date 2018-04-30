#!/bin/sh

## GET INPUT ----------------------------------

# question name (LabXY) = 1st parameter
lab_name=$1

# correct_answer = 2nd parameter
correct_answer=$2


## PREPARE VARIABLES ------------------------

# slice LabXY to LabX (first layer directory name)
lab_folder=`echo $lab_name | cut -b 1-4`

# generate result file naeme
result_file_name="result$lab_name.txt"

## CLEAR OLD FILE ----------------------------- 
if [ -e $result_file_name  ]
then
	rm $result_file_name
fi

## ENTER Labs/ IF EXIST --------------------------------
if [ -e "Labs" ] # directory Labs/ exists
then 
	#goto that folder
	cd "Labs"
else
	#print error message
	echo "Labs directory does not exist"
	#terminates program
	exit 1
fi

## ENTER Labs/LabX IF EXIST ---------------------------
if [ -e $lab_folder ] #if directory Labs/LabX exists
then
	#goto that folder
	cd $lab_folder
else
	#print error message
	echo "$lab_folder does not exist"
	#terminates program
	exit 1
fi

#set positional parameters($1, $2, ..., $n) to name of files and folders in current directory
#in this case, folder of students.
set `ls`   

#for item in those file/folder names
for item in $*
do
	#if the name is directory
	if [ -d $item ]
    	then
		#go in
        	cd $item
        	if gcc $lab_name.c -o temp;
        	then
              		#compile success
              		echo "compile ok"

              		#generate temp files

              		./temp > student_result.txt
              		echo $correct_answer > teacher_result.txt

              		#evaluate result
			student_answer="$(cat student_result.txt)"
			teacher_answer="$(cat teacher_result.txt)"
              		if [ "$student_answer" = "$teacher_answer" ];
              		then
                    		#answer correct
                    		echo "correct answer"
                    		score=3
              		else
                    		#answer wrong
                    		echo "wrong answer"
                    		score=2
              		fi

		#clear temp files
		else
             		#compile error
             		echo "compile failed"
             		score=1
         	fi
        else
        	score=0
       	fi
	#go out
        cd ..
	#file result to file
       	echo "$item;$score" >> "result$lab_name.txt"

done
