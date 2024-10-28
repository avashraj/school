#include <iostream>

int max(int a, int b) { 
    return (a > b) ? a : b; 
} 
  
int max(int a, int b, int c) { 
    return max(max(a, b), c); 
} 
  
int maxCrossingSum(int arr[], int l, int m, int h) { 
    int sum = 0; 
    int left_sum = INT_MIN; 
    for (int i = m; i >= l; i--) { 
        sum = sum + arr[i]; 
        if (sum > left_sum) 
            left_sum = sum; 
    } 
  
    sum = 0; 
    int right_sum = INT_MIN; 
    for (int i = m; i <= h; i++) { 
        sum = sum + arr[i]; 
        if (sum > right_sum) 
            right_sum = sum; 
    } 
  
    return max(left_sum + right_sum - arr[m], left_sum, right_sum); 
} 
  

int maxSubArraySum(int arr[], int l, int h) { 
    if (l > h) {
      return INT_MIN;
  }
    if (l == h) {
        return arr[l]; 
    } 
    int m = (l + h) / 2; 
  
    return max(maxSubArraySum(arr, l, m - 1), 
               maxSubArraySum(arr, m + 1, h), 
               maxCrossingSum(arr, l, m, h)); 
} 


int main(int argc, char **argv) {
  int arrSize = 1;
  std::cin >> arrSize;
  int arr[arrSize];

  for (int i = 0; i < arrSize; i++) {
    std::cin >> arr[i];
  }
  
  std::cout << maxSubArraySum(arr, 0, arrSize - 1);  

  return 0;
}
