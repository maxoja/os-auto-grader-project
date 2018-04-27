#!/bin/sh

lab_name=$1                 #question name (LabXY) = 1st parameter
lab_num=${1:0:4}             #slice LabXY to LabX (first layer directory name)
answer=$2                 #answer = 2nd parameter
cd Labs                 #goto Labs folder

if [ -e $lab_num ]             #if folder LabX exist
then
    cd $lab_num             #goto that folder

else
    echo "$lab_num does not exist"    #print error message
    exit 1                #terminates program
fi

set `ls`                #set positional parameters($1, $2, ..., $n) to name of files and folders in current directory
                    #in this case, folder of students.

for item in $*                #for item in those file/folder names
do
    if [ -d $item ]            #if the name is directory
    then
        cd $item        #go in
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
                    score = 3
              else
                    #answer wrong
                    echo "wrong answer"
                    score = 2
              fi

         #clear temp files
          else
             #compile error
             echo "compile failed"
             score = 1
          fi
        else
            score = 0
        fi
        cd ..            #go out
        echo "$item;$score" >> "result$lab_name.txt"
    fi
done