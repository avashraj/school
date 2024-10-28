#include<iostream>
#include<vector>
#include<time.h>


void swap(int &x, int &y) {
  int temp = x;
  x = y;
  y = temp;
}


int partition(std::vector<int> &arr, int low, int high) {

  int pivot = arr[high];
  int idx = (low - 1);

  for (int j = low; j <= high - 1; j++) {
    if (arr[j] <= pivot) {
      idx++;
      swap(arr[idx], arr[j]);
    }
  }

  swap(arr[idx + 1], arr[high]);
  return (idx + 1);

}


int random_partition(std::vector<int> &arr, int low, int high) {
  int random = low + rand() % (high - low);
  swap(arr[random], arr[high]);
  return partition(arr, low, high);
}


void quicksort(std::vector<int> &arr, int low, int high) {
  if (low < high) {
    int idx = random_partition(arr, low, high);
    quicksort(arr, low, idx - 1);
    quicksort(arr, idx + 1, high);
     
  }
}


int main(int argc, char** argv) {
  srand(time(NULL));
  int arrSize;
  std::cin >> arrSize;

  std::vector<int> arr(arrSize);
  
  for (int i = 0; i < arrSize; i++) {
    std::cin >> arr[i];
  }
  quicksort(arr, 0, arrSize - 1);
  for (int i = 0; i < arrSize; i++) {
    std::cout << arr[i] << ";";
  }
}
