#include <bits/stdc++.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
using namespace std;

int sgn (int a) {
	return (a > 0) - (0 > a);
}

int main () {
	srand (time(NULL));
	
	int bound = (1 << 30);
	int a = rand() % bound;
	int b = rand() % bound;
	
	int asked_questions = 0;
	char type;
	int c, d;
	while (1) {
		cin >> type >> c >> d;
		cerr << type << " " << c << " " << d << endl;
		asked_questions++;
		if ((type != '?'  &&  type != '!') ||  c < 0  ||  d < 0  ||  bound <= c  ||  bound <= d) {
			cerr << "Incorrect question." << endl;
			return 1;
			break;
		}
		
		if (type == '?') {
			if (asked_questions == 63) {
				cerr << "To many questions." << endl;
				return 1;
				break;
			}
			cout << sgn ((a ^ c) - (b ^ d)) << endl;
			cerr << sgn((a ^ c) - (b ^ d)) << endl;
		}
		else {
			if (a == c  &&  b == d)
				cerr << "Correct solution." << endl;
			else {
				cerr << "Incorrect solution." << endl;
				return 1;
			}
			break;
		}
	}
	cerr << "Correct Answers: " << a << " " << b << endl;
	return 0;
}