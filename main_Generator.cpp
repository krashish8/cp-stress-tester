#include <bits/stdc++.h>
using namespace std;

mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
int rand(int l, int r){
    uniform_int_distribution<int> uid(l, r);
    return uid(rng);
}

// Add the argc and argv in the main function to accept the arguments
int main(int argc, char **argv){
    // The testcase is passed as the first argument to the generator (argv[1])
    // Testcases starts from 0 upto (TOTAL_TESTCASE - 1)
    
    // Convert the argument to an integer
    int test = atoi(argv[1]);

    // Generate random test case
    test = rand(1, 100);

    // Generate a fixed testcase according to the testcase number
    cout << test << " " << test * 2 << endl;
}
