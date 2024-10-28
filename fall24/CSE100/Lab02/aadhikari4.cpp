#include <iostream>
#include <vector>

std::vector<int> merge(std::vector<int> arr,
                       std::vector<int> left,
                       std::vector<int> right) {
  int i = 0;
  int j = 0;
  int k = 0;
  while (i < left.size() && j < right.size()) {

    if (left[i] <= right[j]) {
      arr[k] = left[i];
      i++;
      k++;
    } else {
      arr[k] = right[j];
      j++;
      k++;

    }
  }
  
  while(i < left.size()) {
    arr[k] = left[i];
    i++;
    k++;
  }
  while(j < right.size()) {
    arr[k] = right[j];
    j++;
    k++;
  }  
  return arr;
}


std::vector<int> mergesort(std::vector<int> &arr) {

  if (arr.size() > 1) {
    int half = (arr.size() / 2);

    std::vector<int> left;
    std::vector<int> right;

    for (int i = 0; i < half; i++) {
      left.push_back(arr[i]);
    }
    for (int i = half; i < arr.size(); i++) {
      right.push_back(arr[i]);
    }

    left = mergesort(left);
    right = mergesort(right);

    arr = merge(arr, left, right);
  }

  return arr;
}


int main(int argc, char **argv) {
  int arrSize = 1;
  std::cin >> arrSize;
  std::vector<int> arr(arrSize);

  for (int i = 0; i < arrSize; i++) {
    std::cin >> arr[i];
  }
  
  arr = mergesort(arr);
  
  for (int i = 0; i < arrSize; i++) {
    std::cout << arr[i] << ";";
  }
  return 0;
} 
