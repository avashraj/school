#include <iostream>
#include <vector>
using namespace std;

void countingSort(vector<vector<int>>& vectors, int position) {
    int n = vectors.size();
    vector<vector<int>> output(n, vector<int>(10)); 
    int count[4] = {0}; 

    for (int i = 0; i < n; i++) {
        count[vectors[i][position]]++;
    }

    for (int i = 1; i < 4; i++) {
        count[i] += count[i - 1];
    }

    for (int i = n - 1; i >= 0; i--) {
        int digit = vectors[i][position];
        output[count[digit] - 1] = vectors[i];
        count[digit]--;
    }

    for (int i = 0; i < n; i++) {
        vectors[i] = output[i];
    }
}

void radixSort(vector<vector<int>>& vectors) {
    for (int position = 9; position >= 0; position--) {
        countingSort(vectors, position);
    }
}

int main() {
    int num_vectors;
    cin >> num_vectors; 

    vector<vector<int>> vectors(num_vectors, vector<int>(10));

    for (int i = 0; i < num_vectors; i++) {
        for (int j = 0; j < 10; j++) {
            cin >> vectors[i][j];
        }
    }

    radixSort(vectors);

    for (int i = 0; i < num_vectors; i++) {
        for (int j = 0; j < 10; j++) {
            cout << vectors[i][j];
            if (j < 9) cout << ";"; 
        }
        cout << ";" << endl; 
    }

    return 0;
}


