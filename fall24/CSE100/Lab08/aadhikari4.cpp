#include <iostream>
#include <vector>
#include <limits.h>

using namespace std;

void printOptimalParenthesis(vector<vector<int>> &s, int i, int j) {
    if (i == j) {
        cout << "A" << i - 1; 
    } else {
        cout << "(";
        printOptimalParenthesis(s, i, s[i][j]);
        printOptimalParenthesis(s, s[i][j] + 1, j);
        cout << ")";
    }
}

int matrixChainMultiplication(vector<int> &p, int n) {
    vector<vector<int>> m(n, vector<int>(n, 0));
    vector<vector<int>> s(n, vector<int>(n, 0));

    for (int length = 2; length < n; ++length) {
        for (int i = 1; i < n - length + 1; ++i) {
            int j = i + length - 1;
            m[i][j] = INT_MAX;

            for (int k = i; k < j; ++k) {
                int q = m[i][k] + m[k + 1][j] + p[i - 1] * p[k] * p[j];
                if (q < m[i][j]) {
                    m[i][j] = q;
                    s[i][j] = k;
                }
            }
        }
    }

    cout << m[1][n - 1] << endl;

    printOptimalParenthesis(s, 1, n - 1);
    cout << endl;

    return m[1][n - 1];
}

int main() {
    int n;
    cin >> n;
    vector<int> p(n + 1);

    for (int i = 0; i <= n; i++) {
        cin >> p[i];
    }

    matrixChainMultiplication(p, n + 1);

    return 0;
}
