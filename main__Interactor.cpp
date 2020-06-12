#include <bits/stdc++.h>
using namespace std;

mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
int rand(int l, int r){
    uniform_int_distribution<int> uid(l, r);
    return uid(rng);
}

int main() {
    // Generate random test case
    int answer = rand(1,100);
    
    int asked_questions = 0;
    while (true) {
        char user_response_type;
        int response;
        
        // Take the user's response as input
        cin >> user_response_type >> response;
        // Outputting this to stderr for debugging purposes
        cerr << user_response_type << " " << response << endl;
        
        asked_questions++;
        if (asked_questions > 100) {
            cerr << "Too many questions" << endl;     // Outputting every verdict to stderr
            return 1;     // return 1 in case of FAILURE
        }
        
        if (user_response_type == '?') {
            // Give proper response to stdout
            // FOR INTERACTING WITH USER, GIVE THE RESPONSE USING `cout`, FOR GIVING VERDICT, USE `cerr`
            int interactor_response;
            // ...
            cout << interactor_response << endl;
            cerr << interactor_response << endl;     // Outputting this to stderr for debugging purposes
        } else if (user_response_type == '!') {
            if (response == answer) {
                cerr << "Correct solution" << endl;
                break;
            } else {
                cerr << "Incorrect solution." << endl;
                return 1;     // return 1 in case of FAILURE
            }
        }
    }
    // Output the correct answer and return 0 (SUCCESS)
    cerr << "Correct Answer: " << answer << endl;
    return 0;
}
