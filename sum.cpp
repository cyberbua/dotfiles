#include <thread>
#include <iostream>
using namespace std;

long sum1;
long sum2;
long sum3;
long obergrenze, untergrenze;

untergrenze = 0;
obergrenze = 1000;

sum1 = 0;
sum2 = 0;
sum3 = 0;

void singleThread(long obgrenze, long ungrenze, long* sum) {
	*sum = 0;
	for (int i = obgrenze; i <= ungrenze; i++) {
		*sum += i;
		cout << *sum << endl;
	}
	thread t1 = thread(singleThread, obgrenze, ungrenze);
	t1.join();
}

void twoThreads() {
	thread t1 = thread(singleThread, untergrenze , obergrenze / 2);
	thread t2 = thread(singleThread, (obergrenze / 2) + 1, obergrenze);

	t1.join();
	t2.join();
}

void threeThreads() {
	thread t1 = thread(summieren, untergrenze, obergrenze / 3);
	thread t2 = thread(summieren, (obergrenze / 3) + 1, obergrenze / 3 * 2);
	thread t3 = thread(summieren, (obergrenze / 3 * 2 + 1), obergrenze);

	t1.join();
	t2.join();
	t3.join();
}

int main() {
	cout << endl << sum1 + sum2 + sum3 << endl;
	cin.get();
	return EXIT_SUCCESS;
}
