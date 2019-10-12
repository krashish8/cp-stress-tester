# Stress Tester

## Intro

This project contains the files that can be used for Stress Testing the solutions (particularly C++).

## Files

### C++ Files (.cpp)
* `bad.cpp` : Contains Incorrect Solution
* `good.cpp` : Contains Correct Brute-Force Solution
* `generator.cpp` : Contains the code to generate the test cases
* `checker.cpp` : A checker written in C++ to check the validity of solutions (uses the library [`testlib.h`](https://github.com/MikeMirzayanov/testlib))
* `manual_checker.cpp` : A simple checker to check the validity of solutions (in those cases where multiple outputs are possible) -
   So, it requires only `bad.cpp`, not `good.cpp`.

### Bash files (.sh)
* `test.sh` : Checks whether the output produced by "Bad Solution" and "Good Solution" are exactly similar or not.
* `test1.sh` : Uses `manual_checker.cpp` to check whether the "Bad Solution" is correct or not.
* `test_checker.sh` : Uses `checker.cpp` (`testlib.h`) to check the validity of solutions.'

### Library (testlib.h)
* A library used for writing checker.

### Text files (.txt)
* `out_bad.txt` : Contains the output produced by `bad.cpp`.
* `out_good.txt` : Contains the output produced by `good.cpp`.
* `testcase.txt` : Contains the test case used during the checking of solution.
* `verdict.txt` : Contains the final verdict (Accepted / Wrong Answer).

## Usage

### Only one output is possible
* Run `./test.sh`.
* This bash script simply checks whether the files `out_bad.txt` and `out_good.txt` are similar or not.

### Multiple outputs are possible
* Run `./test1.sh`.
* This bash script takes the output produced by `bad.cpp` and feeds it as input in `manual_checker.cpp`.
  The code written in `manual_checker.cpp` returns 1 or 0 depending on whether the solution is incorrect or correct, respectively.

## Both cases
* Run `./checker.sh`.
* This bash script uses `checker.cpp` to check the validity of solutions
