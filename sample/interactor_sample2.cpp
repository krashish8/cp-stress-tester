// June Long Challenge - Guessing Game
// JUNE20A - GUESSG
// Interactor

#include "bits/stdc++.h"
#pragma GCC optimize "03"
using namespace std;

#define int long long int
#define pb push_back
#define pii pair<int,int>
#define fi first
#define se second
#define rep(i,a,b) for (int i = a; i < b; ++i)
#define IOS ios::sync_with_stdio(false); cin.tie(NULL);
#ifndef LOCAL
#define dbg(...) ;
#endif

const int inf = 1e15;
const int MOD = 1e9 + 7;
const int N = 2e5 + 5;

mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
int rand(int l, int r){
    uniform_int_distribution<int> uid(l, r);
    return uid(rng);
}

signed main(){
    IOS;
    int n = 1000000000;
    cout << n << endl;
    cerr << "N: " << n << endl;
    int answer = rand(1, n);
    cerr << "Answer: " << answer << endl;
    int questions = 0;
    bool prev = true;
    while (true) {
        int num;
        cin >> num;
        cerr << num << endl;

        questions++;
        if (questions >= 120) {
            cerr << "Too many questions asked";
            return 1;
        }

        auto give_correct_ans = [&]() {
            if (answer < num) {cout << 'L' << endl; cerr << 'L' << endl;}
            else {cout << 'G' << endl; cerr << 'G' << endl;}
            prev = true;
        };

        auto give_wrong_ans = [&]() {
            if (answer > num) {cout << 'L' << endl; cerr << 'L' << endl;}
            else {cout << 'G' << endl; cerr << 'G' << endl;}
            prev = false;
        };

        auto give_random_ans = [&]() {
            char c = (rand(0, 1) ? 'L' : 'G');
            cout << c << endl;
            cerr << c << endl;
            if (answer < num && c == 'L') prev = true;
            else if (answer > num && c == 'G') prev = true;
            else prev = false;
        };

        if (num == answer) {
            cout << 'E' << endl;
            cerr << 'E' << endl;
            return 0;
        }
        else {
            if (prev == false) give_correct_ans();
            else give_random_ans();
        }
    }
    return 0;
}