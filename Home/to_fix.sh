#!/bin/sh

#question name (LabXY) = 1st parameter
lab_name=$1

#slice LabXY to LabX (first layer directory name)			
lab_num=`echo $lab_name | cut -b 1-4`	

#answer = 2nd parameter	
answer=$2   

#goto Labs folder              
cd Labs                 

#if folder LabX exist
if [ -e $lab_num ]             
then
	#goto that folder
	cd $lab_num             
else
	#print error message
	echo "$lab_num does not exist"    
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
              		echo $answer > teacher_result.txt
              
              		#evaluate result
              		if [ "$(cat student_result.txt)" == "$(cat teacher_result.txt)" ];
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
