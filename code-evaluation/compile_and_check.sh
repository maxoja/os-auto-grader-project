#to use
#chmod +x file.sh
#./file.sh code.c expected_output

code=$1
result=$2

#compile command and check error
if gcc $code -o temp;
then
	#compile success
	echo "compile ok"

	#generate temp files
	./temp > student_result.txt
	echo $result > teacher_result.txt

	#evaluate result
	if [ "$(cat student_result.txt)" == "$(cat teacher_result.txt)" ];
	then
		#answer correct
		echo "correct answer"
	else
		#answer wrong
		echo "wrong answer"
	fi

	#clear temp files
else
	#compile error
	echo "compile failed"
fi
