# Stress Tester

## Intro

This project contains the files that can be used for Stress Testing the solutions (particularly C++). It can be used to find a (smaller) test case in which the main solution fails.

This tester is divided into three types, for testing three different category of problems:
* Normal tester: Used to compare the main solution with a correct brute-force solution.
* Custom tester: Used when the solution may have more than one correct solution.
* Interactive tester: Used for testing the interactive problems.

**Note**:
* For better usage, the file `stress-test.sh` can be added to PATH, or can be moved to `/usr/bin/` directory, by executing the command from the root of this directory:
  ```bash
  sudo cp stress-test.sh /usr/bin/
  ```
* Also, to directly execute it from the Sublime Text (or any IDE), the command to run this file can be added to Sublime Build file, as a variant.
  ```json
  {
      "variants":
      [
          {
              "name": "Stress Tester",
              "shell": false,
              "cmd": ["bash", "-c", "gnome-terminal -- bash -c 'stress-test.sh \"${file}\" normal 500 2; read'"]
          },
          {
              "name": "Custom Tester",
              "shell": false,
              "cmd": ["bash", "-c", "gnome-terminal -- bash -c 'stress-test.sh \"${file}\" custom 500 2; read'"]
          },
          {
              "name": "Interactive Tester",
              "shell": false,
              "cmd": ["bash", "-c", "gnome-terminal -- bash -c 'stress-test.sh \"${file}\" interactive 500 2; read'"]
          },
      ]
  }
  ```
## Usage

   ```
   ./stress-test.sh <file.cpp> ...[optional_parameters]...
   
   All the cpp files should be present in the same directory

   Optional Parameters:
   
       These parameters must follow the order given:

       <testing_type>      Must be either 'normal', 'custom' or 'interactive'.
                            normal: Testing the normal problems
                            custom: Testing the solutions which require custom tester
                            interactive: Testing the interactive problems
                           [DEFAULT]: normal

       <no_of_testcases>   Total number of testcases to check.
                           [DEFAULT]: 500

       <timeout>           Timeout of each execution (given in seconds)
                           [DEFAULT]: 2 (2 seconds)
   ```

## Description

For all the below examples, suppose the main solution to test has the filename: `main.cpp`.  
For all the files mentioned below, note that __ means **two** underscores.  
The extra files required for testing are named as `'main file' + '__' + '[type].cpp'`, as described below.

**Usage:** `./stress-test.sh main.cpp ...[optional parameters]...`

### Normal testing

The directory containing the file `main.cpp` should have the following files:

* `main.cpp`:
  - The main solution file to test.
* `main__Good.cpp`:
  - The correct, brute force solution.
* `main__Generator.cpp`:
  - The file to generate random test cases.
  - It should output the test case to the standard output stream (`stdout`) using `cout`.

### Custom testing

The directory containing the file `main.cpp` should have the following files:

* `main.cpp`:
  - The main solution file to test.
* `main__Checker.cpp`:
  - The file to test the solution, which has more than one correct solution.
  - First, it should take two types of input from the standard input stream (`stdin`) using `cin` in the following order:
    1. The first input is the testcase produced by the generator: `main__Generator.cpp`.
    2. The second input is the answer produced by the main solution file: `main.cpp`.
  - It should give verdict to the standard error stream (`stderr`) using `cerr`. First, it should output an `endl` (for better readability), and then give the verdict such as `Expected ... found ...` to `cerr`.
  - Finally, it should `return 0` in case of SUCCESS, or `return 1` in case of FAILURE.
  - Note: Every response to the user is given using `cerr`.
* `main__Generator.cpp`:
  - The file to generate random test cases.
  - It should output the test case to the standard output stream (`cout`).

### Interactive testing

The directory containing the file `main.cpp` should have the following files:

* `main.cpp`:
  - The main solution file to test.
* `main__Interactor.cpp`:
  - This file acts as a generator and an interactor (to generate random test case and to interact with the main solution).
  - It should first generate a random test case - e.g. the number to guess.
  - Then rest of the code is written inside an infinite while loop
  - It should first take the output produced by the main solution from the standard input stream (`stdin`) using `cin`.
  - It should then output the response to the standard output stream (`stdout`) using `cout`.
  - For printing any verdict or the testcase (if an error occurred), it should output the response to the standard error stream (`stderr`) using `cerr`.
  - Note: To interact with the user, output is given using `cout` and other outputs related to verdicts are given using `cerr`.
  - So, along with `cout`, write the same output to `cerr` for debugging purposes.
  - After every interaction, it should validate:
    1. Checking whether the number of questions asked is within limits.
    2. Checking whether the response of the user is correct or not.
  - In case of any error, it should output it using `cerr` and simultaneously `return 1`.
  - In case the answer is correct, it gives appropriate verdict using `cerr` and returns 0.
  - Also, for debugging purposes, print the correct output using `cerr` at the end of this file, before returning 0 or 1.
