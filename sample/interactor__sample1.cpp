// June Long Challenge - Covid Sampling (Challenge)
// JUNE20A - COVDSMPL
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
    int T = 2;
    cout << T << endl;
#ifdef DEBUG
    cerr << T << endl;
#endif

    int cost = 0;

    while (T--) {
        int n = 60, p = 15; // adjust p accordingly
        cout << n << " " << p << endl;
        cerr << n << " " << p << endl;
        int a[65][65];
        for (int i = 1; i <= 60; i++) {
            for (int j = 1; j <= 60; j++) {
                a[i][j] = (rand(1, 100) <= p);
            }
        }
        int queries = 0;
        while (true) {
            int type;
            cin >> type;
#ifdef DEBUG
            cerr << type << " ";
#endif
            queries++;
            if (queries >= 5 * n * n) {
                cerr << "Too many questions asked";
                return 1;
            }
            if (type == 1) {
                int r1, c1, r2, c2;
                cin >> r1 >> c1 >> r2 >> c2;
#ifdef DEBUG
                cerr << r1 << " " << c1 << " " << r2 << " " << c2 << endl;
#endif


                int cnt = 0;
                for (int i = r1; i <= r2; i++) {
                    for (int j = c1; j <= c2; j++) {
                        cnt += (a[i][j] == 1);
                    }
                }
                int a = r2 - r1 + 1, b = c2 - c1 + 1;
                cost += ((2*n - a) * (2*n - b) + cnt) / (cnt + 1);
                cout << cnt << endl;
#ifdef DEBUG
                cerr << cnt << endl;
#endif
            }
            else {
                int flag = 1;
                for (int i = 1; i <= n; i++) {
                    for (int j = 1; j <= n; j++) {
                        int val;
                        cin >> val;
#ifdef DEBUG
                        cerr << val << " ";
#endif
                        if (val != a[i][j]) flag = 0;
                    }
#ifdef DEBUG
                    cerr << endl;
#endif
                }
                if (!flag) {
                    cout << -1 << endl;
#ifdef DEBUG
                    cerr << -1 << endl;
#endif
                    return 1;
                }
                else cout << 1 << endl;
                break;
            }
        }
    }
    cerr << cost << endl;
    return 0;
}