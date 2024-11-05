#include <stdio.h>

int sum(int n, int m) {
    return n + m;
}

int main() {
    int m = 10;
    int n = 5;

    int res = sum(m, n);

    printf("%d", res);
}

