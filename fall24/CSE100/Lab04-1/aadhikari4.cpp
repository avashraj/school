#include <iostream>
#include <vector>

//function to swap the values of its two arguments
void swap(int &x, int& y) {
  int temp = x;
  x = y;
  y = temp;
}


void heapify(std::vector<int>& arr, int n, int i) {
  int largest = i;

  int left = 2 * i + 1;
  int right = 2 * i + 2;

  if (left < n && arr[left] > arr[largest]) {
    largest = left;
  }

  if (right < n && arr[right] > arr[largest]) {
    largest = right;
  }

  if (largest != i) {
    swap(arr[largest],arr[i]);
    heapify(arr, n, largest);
  }
  
}

void heapsort(std::vector<int>& arr) {
  int n = arr.size();

  for(int i = n/2 - 1; i >=0; i--) {
    heapify(arr, n, i);
  }

  for (int i = n - 1; i > 0; i--) {
    swap(arr[0], arr[i]);
    heapify(arr, i, 0);
  }
}


int main(int argc, char **argv) {
  int arrSize;
  std::cin >> arrSize;
  std::vector<int> arr(arrSize);
  for(int i = 0; i < arrSize; i++) {
    std::cin >> arr[i];
  }
  
  heapsort(arr);

  for (int i = 0; i < arrSize; i++) {
    std::cout << arr[i] << ";";
  }

  return 0;
}
