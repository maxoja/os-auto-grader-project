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
if [ -e "Labs" ] 	# directory Labs/ exists
then 
	cd "Labs"		# goto that folder
else
	
	echo "Labs directory does not exist"	# print error message
	exit 1														# terminates program
fi




## ENTER Labs/LabX IF EXIST ---------------------------
if [ -e $lab_folder ] 		# if directory Labs/LabX exists
then
	cd $lab_folder			# goto that folder
else
	echo "$lab_folder does not exist"	# print error message
	exit 1													# terminates program
fi




## START TO LOOP OVER STUDENTS ----------------------

#set positional parameters($1, $2, ..., $n) to name of files and folders in current directory
#in this case, folder of students.
set `ls`   

for student_folder in $* 		# for student_folder in those file/folder names
do
	
	if [ -d $student_folder ]	# if the name is directory
	then
		if [ -e $lab_name.c ]
		then
			cd $student_folder						# go in
			if gcc $lab_name.c -o "temp" 2>&1 | grep -v "";			# if compile success
			then 
				echo "compile ok"					#print compile ok

				./temp > "student_result.txt"				#create temp file store student result
				echo $correct_answer > "teacher_result.txt"		#create temp file store teacher result
				teacher="$(cat teacher_result.txt)"
				student="$(cat student_result.txt)"
				if [ $teacher = $student ];	#check if same output as expected
				then #answer correct then set score=3
						echo "correct answer"
						score=3
				else #answer wrong then set score=3
						echo "wrong answer"
						score=2
				fi

				rm "student_result.txt"		# clear temp files
				rm "teacher_result.txt"
				rm "temp"
			else #compile error and score=1
				echo "compile failed"
				score=1
			fi

			score=0

		
		fi
		cd ../../..
		echo "$student_folder;$score" >> "result$lab_name.txt"	#push result file
		cd Home/Labs/$lab_folder	#go in to Labs/LabX/

	fi
done
