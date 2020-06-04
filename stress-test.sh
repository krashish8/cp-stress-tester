#!/bin/bash

# For better usage of this file, it can be added to PATH or directly moved to /bin folder.
# Also, the command to run this file can be added to Sublime Build file, as a variant.

# Usage:
#
#   ./stress-test.sh <file.cpp> ...[optional_parameters]...
#   All the cpp files should be present in the same directory
#
#   Optional Parameters:
#       These parameters must follow the order given
#
#       <testing_type>      Must be either normal, custom or interactive.
#                           normal: Testing the normal problems
#                           custom: Testing the solutions which require custom tester
#                           interactive: Testing the interactive problems
#                           DEFAULT: normal
#
#       <no_of_testcases>   Total number of testcases to check.
#                           DEFAULT: 500
#
#       <timeout>           Timeout of each execution (given in seconds)
#                           DEFAULT: 2s


#   For this example, suppose that the file passed as the first argument is 1.cpp

# Normal Testing:

#   Three files are required:
#   (I) 1.cpp: Main solution file.
#   (II) 1__Good.cpp: The correct solution file, or the Brute force solution.
#   (III) 1__Generator.cpp: The file to generate the test cases. This file outputs a random test
#                           case to the standard output stream (cout).

#   All the object codes of the cpp files will be created in ./tempfiles.
#   Test case of the last execution will be stored in 1__Testcase.txt
#   The output produced by the main solution will be stored in 1__Output_Main.txt
#   The output produced by the correct solution will be stored in 1__Output_Good.txt
#   The final verdict will be stored in 1__Verdict.txt

# Custom Testing:

#   Three files are required:
#   (I) 1.cpp: Main solution file.
#   (II) 1__Checker.cpp: This file takes the testcase produced by generator and then the answer produced
#                        by the main solution file. It then validates the answer, outputs endl alongwith
#                        any verdict produced by the judge as standard error stream (stderr). Finally,
#                        it returns 1 if error occured, or returns 0 in case of success.
#   (III) 1__Generator.cpp: The file to generate the test cases. This file outputs a random test
#                           case to the standard output stream (cout).

#   All the object codes of the cpp files will be created in ./tempfiles.
#   Test case of the last execution will be stored in 1__Testcase.txt
#   The output produced by the main solution will be stored in 1__Output_Main.txt
#   The combination of testcase and output produced will be stored in 1__Combined.txt
#   The final verdict will be stored in 1__Verdict.txt

# Interactive Problems Testing:

#   Two files are required:
#   (I) 1.cpp: Main solution file.
#   (II) 1__Interactor.cpp: (It acts as both generator and interactor)
#       This file creates a random test case, probably the answer chosen by the judge
#       (similar to generator) and then inside an infinite while loop, it takes the output
#       produced by the main solution as standard input stream (cin) and outputs the response
#       as standard output stream (cout). Simultaneously, for every cin and cout, it sends
#       those results to cerr too, for printing the testcase (in case an error occured).
#       It validates the input, checking whether the number of questions asked is under limit
#       and whether the answer is correct or not, and in case of any error, it outputs the
#       verdict as standard error stream (cerr), simultaneously returns 1. Otherwise, it
#       returns 0. Also, it outputs the correct answer to standard error stream (cerr).

#   All the object codes of the cpp files will be created in ./tempfiles.
#   Test case of the last interaction will be stored in 1__Testcase.txt
#   The final verdict will be stored in 1__Verdict.txt

show_help() {
    echo "
Usage: ./stress-test.sh <file.cpp> ...[optional_parameters]...
       All the cpp files should be present in the same directory

Optional Parameters:
    These parameters must follow the order given

    <testing_type>      Must be either normal, custom or interactive.
                        normal: Testing the normal problems
                        custom: Testing the solutions which require custom tester
                        interactive: Testing the interactive problems
                        DEFAULT: normal

    <no_of_testcases>   Total number of testcases to check.
                        DEFAULT: 500

    <timeout>           Timeout of each execution (given in seconds)
                        DEFAULT: 2s
"
}

print_args() {
    echo "
File Submitted: $1
Testing Type: $2
Number of Testcases: $3
Timeout: $4
    "
}

make_dir() {
    if [ ! -d $1 ];
    then
        mkdir $1
    fi
}

remove_dir() {
    rm -rf $1
}

compile() {
    if g++ $2 -o $3; # Compiling the code to be tested
    then
        echo "$1 compiled successfully."
    else
        echo "$1 compilation failed."
        echo ""
        exit 1
    fi
}

run() {
    if [[ $1 == "Generator" ]]; then
        # if ! timeout $TIMEOUT $GENERATOR_EXEC > $TESTCASE_FILE
        if ! timeout $2 $3 > $4; then
            VERDICT="\n$1 execution failed due to timeout or runtime errors.\n\nTest Case: \n$(cat $4)"
            echo -e "${VERDICT}" | tee $5 # echo -e "${VERDICT}" | tee $VERDICT_FILE
            exit 1
        fi
    elif [[ $1 == "Checker" ]]; then
        # if ! $CHECKER_EXEC < $COMBINED_FILE > $VERDICT_FILE
        if ! $3 < $4 > $5; then
            # VERDICT="\n\nTest Case: \n$(cat $TESTCASE_FILE) \n\nOutput: \n$(cat $MAIN_FILE_OUTPUT) \n\nWrong Answer \n\n"
            VERDICT="\n\nTest Case: \n$(cat $6) \n\nOutput: \n$(cat $7) \n\nWrong Answer \n\n"
            echo -e "${VERDICT}" | tee $5
            exit 1
        fi
    else
        # if ! timeout $TIMEOUT $GOOD_FILE_EXEC < $TESTCASE_FILE > $GOOD_FILE_OUTPUT
        if ! timeout $2 $3 < $4 > $5; then
            VERDICT="\n$1 execution failed due to timeout or runtime errors.\n\nTest Case: \n$(cat $4)"
            echo -e "${VERDICT}" | tee $6 # echo -e "${VERDICT}" | tee $VERDICT_FILE
            exit 1
        fi
    fi
}

regex_int='^[0-9]+$'
regex_num='^[0-9]+([.][0-9]+)?$'

ARG_NUM=$#

# Solution File Name
if [[ $1 == *.cpp ]]; then
    ARG1=$1
else
    show_help
    exit
fi

# Type of testing - DEFAULT normal
if [[ -z "$2" ]]; then
    ARG2="normal"
    ((ARG_NUM++))
elif [[ $2 == "normal" ]] || [[ $2 == "custom" ]] || [[ $2 == "interactive" ]]; then
    ARG2=$2
else
    show_help
    exit
fi

# Number of test cases - DEFAULT 500
if [[ -z "$3" ]]; then
    ARG3="500"
    ((ARG_NUM++))
elif [[ $3 =~ $regex_int ]]; then
    ARG3=$3
else
    show_help
    exit
fi

# Timeout of each execution - DEFAULT 2s
if [[ -z "$4" ]]; then
    ARG4="2s"
    ((ARG_NUM++))
elif [[ $4 =~ $regex_num ]]; then
    ARG4="${4}s"
else
    show_help
    exit
fi

if [[ $ARG_NUM -ne 4 ]]; then
    show_help
    exit
else
    TESTING_TYPE=$ARG2
    NO_OF_TESTCASES=$ARG3
    TIMEOUT=$ARG4

    full_filename=$(basename -- "$ARG1")
    extension="${full_filename##*.}"
    filename="${full_filename%.*}"

    print_args $full_filename $TESTING_TYPE $NO_OF_TESTCASES $TIMEOUT

    DIR="$( cd "$( dirname "$ARG1" )" && pwd )"
    TEMPFILES_DIR="${DIR}/tempfiles"

    MAIN_FILE="${DIR}/${filename}.$extension"
    MAIN_FILE_EXEC="${TEMPFILES_DIR}/${filename}"

    GOOD_FILE="${DIR}/${filename}__Good.$extension"
    GOOD_FILE_EXEC="${TEMPFILES_DIR}/${filename}__Good"

    GENERATOR="${DIR}/${filename}__Generator.$extension"
    GENERATOR_EXEC="${TEMPFILES_DIR}/${filename}__Generator"

    CHECKER="${DIR}/${filename}__Checker.$extension"
    CHECKER_EXEC="${TEMPFILES_DIR}/${filename}__Checker"

    INTERACTOR="${DIR}/${filename}__Interactor.$extension"
    INTERACTOR_EXEC="${TEMPFILES_DIR}/${filename}__Interactor"

    TESTCASE_FILE="${DIR}/${filename}__Testcase.txt"
    MAIN_FILE_OUTPUT="${DIR}/${filename}__Output_Main.txt"
    GOOD_FILE_OUTPUT="${DIR}/${filename}__Output_Good.txt"
    VERDICT_FILE="${DIR}/${filename}__Verdict.txt"
    COMBINED_FILE="${DIR}/${filename}__Combined.txt"
    FIFO_FILE="${DIR}/fifo"

    make_dir $TEMPFILES_DIR

    compile "Main Solution" $MAIN_FILE $MAIN_FILE_EXEC

    if [[ $TESTING_TYPE == "normal" ]]; then

        compile "Generator" $GENERATOR $GENERATOR_EXEC
        compile "Good Solution" $GOOD_FILE $GOOD_FILE_EXEC

        VERDICT="\nAccepted"
        echo ""

        for((i = 0; i < $NO_OF_TESTCASES; i++)); do

            echo -e "Running Test Case #$i"

            run "Generator" $TIMEOUT $GENERATOR_EXEC $TESTCASE_FILE $VERDICT_FILE
            run "Good Solution" $TIMEOUT $GOOD_FILE_EXEC $TESTCASE_FILE $GOOD_FILE_OUTPUT $VERDICT_FILE
            run "Main Solution" $TIMEOUT $MAIN_FILE_EXEC $TESTCASE_FILE $MAIN_FILE_OUTPUT $VERDICT_FILE
            
            if ! diff $GOOD_FILE_OUTPUT $MAIN_FILE_OUTPUT >/dev/null ; then
                VERDICT="\nTest Case: \n$(cat $TESTCASE_FILE) \n\nExpected: \n$(cat $GOOD_FILE_OUTPUT) \n\nFound: \n$(cat $MAIN_FILE_OUTPUT) \n\nWrong Answer"
                break
            fi
        done
        
        echo -e "${VERDICT}" | tee $VERDICT_FILE


    elif [[ $TESTING_TYPE == "custom" ]]; then

        compile "Generator" $GENERATOR $GENERATOR_EXEC
        compile "Checker" $CHECKER $CHECKER_EXEC

        echo ""

        VERDICT="\nAccepted"

        for((i = 0; i < $NO_OF_TESTCASES; i++)); do

            echo -e "Running Test Case #$i"

            run "Generator" $TIMEOUT $GENERATOR_EXEC $TESTCASE_FILE $VERDICT_FILE
            run "Main Solution" $TIMEOUT $MAIN_FILE_EXEC $TESTCASE_FILE $MAIN_FILE_OUTPUT $VERDICT_FILE

            echo >> $TESTCASE_FILE
            cat $TESTCASE_FILE $MAIN_FILE_OUTPUT > $COMBINED_FILE

            run "Checker" $TIMEOUT $CHECKER_EXEC $COMBINED_FILE $VERDICT_FILE $TESTCASE_FILE $MAIN_FILE_OUTPUT
        done

        echo -e "${VERDICT}" | tee $VERDICT_FILE

    elif [[ $TESTING_TYPE == "interactive" ]]; then

        compile "Interactor" $INTERACTOR $INTERACTOR_EXEC
        echo ""

        VERDICT="\nAccepted"

        for((i = 0; i < $NO_OF_TESTCASES; i++)); do

            echo -e "Running Test Case #$i"

            rm -rf $FIFO_FILE
            mkfifo $FIFO_FILE

            if ! timeout $TIMEOUT $MAIN_FILE_EXEC < $FIFO_FILE | $INTERACTOR_EXEC > $FIFO_FILE 2> $TESTCASE_FILE; then
                echo "Execution Failed: Wrong Solution or Timeout errors."
                echo ""
                VERDICT=""
                cat $TESTCASE_FILE
                break
            fi
        done

        echo -e "${VERDICT}" | tee $VERDICT_FILE

    fi
fi

echo
