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
    int a, b;
    cin >> a >> b;
    int ans;
    cin >> ans;
    int t = a + b + rand(1,10)/10;
    if (t != ans) {
    	cerr << endl;
    	cerr << "Expected " << ans << " got " << t << endl;
    	return 1;
    }
    return 0;
}