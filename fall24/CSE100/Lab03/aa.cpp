#include <iostream>
#include <tuple>


std::tuple<int, int, int> findMaxCrossSubArray(int a[], int low, int mid, int high) {
  int left_sum = INT_MIN;
  int sum = 0;
  int max_left = mid;

  for (int i = mid - 1; i >= low; i--) {
    sum = sum + a[i];
    if (sum > left_sum) {
      left_sum = sum;
      max_left = i;
    }
  }
    
  int right_sum  = INT_MIN;
  sum = 0;
  int max_right = mid;
  for (int i = mid; i <= high; i++) {
    sum = sum + a[i];
    if (sum > right_sum) {
      right_sum = sum;
      max_right = i;
    }
  }

  return std::make_tuple(max_left,max_right, left_sum + right_sum);
}

std::tuple<int, int, int> findMaxSubArray(int a[], int low, int high) {
  if (low == high) {
    return std::make_tuple(low, high, a[low]);
  } else {
    int mid = (low + high) / 2;

    std::tuple<int, int, int> left = findMaxSubArray(a, low, mid);
    int left_low = std::get<0>(left);
    int left_high = std::get<1>(left);
    int left_sum = std::get<2>(left);

    std::tuple<int, int, int> right = findMaxSubArray(a, mid + 1, high);
    int right_low = std::get<0>(right);
    int right_high = std::get<1>(right);
    int right_sum = std::get<2>(right);

    std::tuple<int,int,int> cross = findMaxCrossSubArray(a, low, mid, high);
    int cross_low = std::get<0>(cross);
    int cross_high = std::get<1>(cross);
    int cross_sum = std::get<2>(cross);
    
    if (left_sum >= right_sum && left_sum >= cross_sum) {
      return std::make_tuple(left_low, left_high, left_sum);
    } else if (right_sum >= left_sum && right_sum >= cross_sum) {
      return std::make_tuple(right_low, right_high, right_sum);
    } else {
      return std::make_tuple(cross_low, cross_high, cross_sum);
    }
  }
}
int main(int argc, char **argv) {
  int arrSize = 1;
  std::cin >> arrSize;
  int arr[arrSize];

  for (int i = 0; i < arrSize; i++) {
    std::cin >> arr[i];
  }
  
  std::tuple<int, int, int> res = findMaxSubArray(arr, 0, arrSize - 1);
  std::cout << std::get<2>(res) << std::endl;

  return 0;
}


