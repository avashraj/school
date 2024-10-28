#include <iostream>

int main(int argc, char **argv) {

  int arrSize = 1; //create variable to store array size
  std::cin >> arrSize; //get first input for array size

  int* arr = new int[arrSize]; //we make an int ptr to make an array that we dont know the size of yet

  //populate array from std input
  for(int i=0; i<arrSize; i++) {
    std::cin >> arr[i];
  }

  //INSERTION SORT:

  //from the second element to the end of the list
  for (int i=1; i<arrSize; i++) {
    
    //we set key to be the element we want to insert
    int key = arr[i];

    //j will be the pointer to the last sorted element
    int j = i - 1;

    //we go thru and shift elements to the right if they are bigger than the key 
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j--;
    }
    
    //once we are in the correct spot, we insert at the correct location
    arr[j + 1] = key;

    //stuff to print out list for Grade
    for (int k = 0; k < i + 1; k++) {
      std::cout << arr[k] << ";";
    }
    std::cout << std::endl;
  }
  //need to free allocated memory
  delete[] arr;
}
