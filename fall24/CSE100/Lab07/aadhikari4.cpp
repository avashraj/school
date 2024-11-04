#include <iostream>
#include <vector>
#include <climits>


using namespace std;

void bottom_up_rod(vector<int>& rod, int length) {
    vector<int> revenue(length + 1, 0);
    vector<int> cut_position(length + 1, 0); 
    for (int i = 1; i <= length; i++) {
        int q = INT_MIN;
        for (int j = 1; j <= i; j++) {
            if (q < rod[j] + revenue[i - j]) {
                q = rod[j] + revenue[i - j];
                cut_position[i] = j; 
            }
        }
        revenue[i] = q;
    }

    cout << revenue[length] << endl;

    int n = length;
    while (n > 0) {
        cout << cut_position[n] << " ";
        n -= cut_position[n];
    }
    cout << "-1" << endl;
}

int main() {
    int rod_length;
    cin >> rod_length;
    vector<int> rod(rod_length + 1, 0);       

    for (int i = 1; i <= rod_length; i++) {
        cin >> rod[i];
    }

    bottom_up_rod(rod, rod_length);
    
}
