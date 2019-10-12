#include "bits/stdc++.h"
#include "testlib.h"
using namespace std;

#include "bits/stdc++.h"
#pragma GCC optimize "03"
using namespace std;

#define pb push_back
#define pii pair<int,int>
#define fi first
#define se second
#define rep(i,a,b) for (int i = a; i < b; ++i)

int main(int argc, char* argv[]){ // You need to include "testlib.h" and download it.
	registerTestlibCmd(argc,argv); // Initialization of the checker streams
	long long jans = ans.readLong(); // Answer output
	long long pans = ouf.readLong(); // Participant output
	if(jans != pans) quitf(_wa, "Wrong answer. Expected %lld, found %lld",jans,pans); // Checking the correctness
	quitf(_ok,"Accepted"); // No problem -> AC
	return 0;
}
