#include <bits/stdc++.h>
using namespace std;

int main() {
    // Take the testcase as input
    int testcase;
    cin >> testcase;
    
    // Take the answer produced by main solution as input
    int answer;
    cin >> answer;
    
    // Check whether the answer produced satisfies the test case
    int expected_answer;
    bool is_correct = false;
    // ...
    if (is_correct) {
        // Output the verdict to stderr
        cerr << endl;
        cerr << "Expected " << expected_answer << ", found " << answer << endl;
        return 1;     // return 1 in case of FAILURE
    }
    return 0;     // return 0 in case of SUCCESS
}
