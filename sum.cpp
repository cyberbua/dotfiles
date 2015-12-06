#include <thread>
#include <iostream>
using namespace std;

long sum1 = 0;
long sum2 = 0;
long sum3 = 0;
long obergrenze = 1000;
long untergrenze = 0;

void singleThread(long obgrenze, long ungrenze, long& sum) {
	sum = 0;
	for (int i = obgrenze; i <= ungrenze; i++) {
		sum += i;
		// cout << *sum << endl;
	}
}

void twoThreads() {
	thread t1 = thread(singleThread, untergrenze , obergrenze/2, ref(sum1));
	thread t2 = thread(singleThread, (obergrenze/2)+1, obergrenze, ref(sum2));

	t1.join();
	t2.join();
}

void threeThreads() {
	thread t1 = thread(singleThread, untergrenze, obergrenze/3, ref(sum1));
	thread t2 = thread(singleThread, (obergrenze/3)+1, (obergrenze/3)*2, ref(sum2));
	thread t3 = thread(singleThread, ((obergrenze/3) * 2)+1, obergrenze, ref(sum3));

	t1.join();
	t2.join();
	t3.join();
}

int main() {
    twoThreads();
    long total = sum1 + sum2;
	cout << endl << total << endl;

    //partialsummen resetten
    sum1 = 0;
    sum2 = 0;
    threeThreads();
    total = sum1 + sum2 + sum3;
    cout << endl << total << endl;

	cin.get();
	return 0;
}

