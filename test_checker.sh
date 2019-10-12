#!/bin/bash

if g++ generator.cpp -o ./tempfiles/generator; # Random testcase generator
then
	echo "Generator compiled successfully."
else
	echo "Generator compilation failed."
	echo ""
	exit 1
fi

if g++ checker.cpp -o ./tempfiles/checker; # Answer checker
then
	echo "Checker compiled successfully."
else
	echo "Checker compilation failed."
	echo ""
	exit 1
fi

if g++ good.cpp -o ./tempfiles/good; # Bruteforce correct solution
then
	echo "Good Solution compiled successfully."
else
	echo "Good Solution compilation failed."
	echo ""
	exit 1
fi

if [ "$#" -eq 0 ]; then # C++
	if g++ -static -DONLINE_JUDGE -lm bad.cpp -o ./tempfiles/bad; # Compiling the code to be tested
	then
		echo "Bad Solution compiled successfully."
		echo ""
	else
		echo "Bas Solution compilation failed."
		echo ""
		exit 1
	fi
	
	ver="Accepted"
	for((i = 0; i < 300; i++)); do # Test 300 cases
		if ! timeout 2s ./tempfiles/generator > testcase.txt; then
			echo "Generator execution failed due to timeout or runtime errors."
			echo ""
			exit 1
		fi
		echo "Running on test $i"
		if ! timeout 2s ./tempfiles/good < testcase.txt > out_good.txt; then
			echo "Good Solution execution failed due to timeout or runtime errors."
			echo ""
			exit 1
		fi
		if ! timeout 2s ./tempfiles/bad < testcase.txt > out_bad.txt; then
			echo "Bad Solution execution failed due to timeout or runtime errors."
			echo ""
			exit 1
		fi
		./tempfiles/checker testcase.txt out_bad.txt out_good.txt verdict.txt # Checker receives input, jury answer and participant output. Verdict goes to file "verdict.txt"
		ver=$(cat verdict.txt) # Have just "Accepted" if the code is correct, other message means that the code was wrong
		if [ "$ver" != "Accepted" ]; then
			break
		fi
	done
elif [ $1 -eq 2 ]; then # Java
	javac JavaHack.java
	for((i = 0; i < 300; i++)); do
		"./Gen$1" > int
		echo "Running on test $i"
		./Solution < int > out1
		timeout 20 java JavaHack < int > out2
		./Checker int out2 out1 ver
		ver=$(cat ver)
		if [ "$ver" != "Accepted" ]; then
			break
		fi
	done
elif [ $1 -eq 3 ]; then # Python (needs a third argument with the Python version)
	for((i = 0; i < 300; i++)); do
		"./Gen$1" > int
		echo "Running on test $i"
		./Solution < int > out1
		timeout 2 "python$2" pythonHack.py < int > out2
		./Checker int out2 out1 ver
		ver=$(cat ver)
		if [ "$ver" != "Accepted" ]; then
			break
		fi
	done
else # Kotlin
	kotlinc kotlinHack.kt -include-runtime -d kotlinHack.jar
	for((i = 0; i < 300; i++)); do
		"./Gen$1" > int
		echo "Running on test $i"
		./Solution < int > out1
		timeout 20 java -jar kotlinHack.jar < int > out2
		./Checker int out2 out1 ver
		ver=$(cat ver)
		if [ "$ver" != "Accepted" ]; then
			break
		fi
	done
fi

if [ "$ver" == "Accepted" ]; then
	echo $ver
else
	echo "$ver on test $tc"
	cat testcase.txt
fi
