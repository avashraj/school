
#include <stdio.h>
#include <stdlib.h>

int** matMult(int **a, int **b, int size) {
	// (4) Implement your matrix multiplication here. 
	// You will need to create a new matrix to store the product.
	int** res = (int**)malloc(size * sizeof(int*));
  for (int i = 0; i < size; i++) {
    *(res + i) = (int*)malloc(size * sizeof(int));
  }
  
     
  //rows of a
  for (int i = 0; i < size; i++) {
    //columns of b
    for (int j = 0; j < size; j++) {
      int temp = 0; 
      //to compute dot product of row & column
      for (int k = 0; k < size; k++) {
        temp += *(*(a + i) + k) * *(*(b + k) + j); 
      }

      *(*(res + i) + j) = temp;
    }
  }
  return res;
}

void printArray(int **arr, int n) {
	// (2) Implement your printArray function here
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
        printf("%d ", *(*(arr + i) + j));
    }
    printf("\n");
  }
}

int main() {
	int n = 3;
	int **matA, **matB, **matC;
	// (1) Define 2 (n x n) arrays (matrices). 
	matA = (int**)malloc(n * sizeof(int*));
	matB = (int**)malloc(n * sizeof(int*));

  int arr1[9] = {1,3,4,5,6,1,9,4,5};
  int arr2[9] = {6,1,9,2,6,1,2,4,6};

  for (int i = 0; i < n; i++) {
    *(matA + i) = (int*)malloc(n * sizeof(int));
  }
  int counter = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++){
      *(*(matA + i) + j) = *(arr1 + counter);
      counter++;
    }
  }

  for (int i = 0; i < n; i++) {
    *(matB + i) = (int*)malloc(n * sizeof(int));
  }
  counter = 0;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++){
      *(*(matB + i) + j) =  *(arr2 + counter);
      counter++;
    }
  }

	// (3) Call printArray to print out the 2 arrays here.
  printArray(matA, n);
  printf("\n");
  printArray(matB, n);
	
	// (5) Call matMult to multiply the 2 arrays here.
  int** result = matMult(matA, matB, n); 	
	
	// (6) Call printArray to print out resulting array here.
  printf("\n");
  printArray(result, n);

    return 0;
}
