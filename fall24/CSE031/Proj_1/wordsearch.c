#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
// need a function to make every letter in input word capitalized
// need a function to print search path


char* capitalizeWord(char* word);
int getMatrixSize(char** b);
void printSearchPath();
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
int bSize;

// Main function, DO NOT MODIFY 	
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    int i, j;
    FILE *fptr;

    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }

    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));

    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);            
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    fclose(fptr);

    printf("Enter the word to search: ");
    scanf("%s", word);
    
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}


int getMatrixSize(char **matrix) {
    int count = 0;
    while (*(*matrix + count) != '\0') {
        count++;
    }
    return count;
}


void printPuzzle(char** arr) {
    int size = getMatrixSize(arr);

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%c ", *(*(arr + i) + j));
        }
        printf("\n");
    }
    printf("\n");
}

char* capitalizeWord(char* word) {
    int i = 0;
    for (i = 0; *(word + i) != '\0'; i++) {
        if (*(word + i) >= 'a' && *(word + i) <='z') {
            *(word + i) = *(word + i) - 32;
        }
    }
    *(word + i) = '\0';
    return word;
}


bool dfs(char **arr, char *word, int row, int col, int index, int **path) {
    int size = getMatrixSize(arr);  // Get the size of the board
    int len = strlen(word);

    if (index == len) return true;

    if (row < 0 || row >= size || col < 0 || col >= size || *(*(arr + row) + col) != *(word + index)) {
        return false;
    }

    if (*(*(path + row) + col) == 0) {
        *(*(path + row) + col) = index + 1;  
    } else {
        *(*(path + row) + col) = *(*(path + row) + col) * 10 + (index + 1);
    }

    int rowOffsets[] = {-1, -1, -1, 0, 0, 1, 1, 1};
    int colOffsets[] = {-1, 0, 1, -1, 1, -1, 0, 1};
    for (int i = 0; i < 8; i++) {
        if (dfs(arr, word, row + rowOffsets[i], col + colOffsets[i], index + 1, path)) {
            return true;  
        }
    }

    if (*(*(path + row) + col) == index + 1) {  
        *(*(path + row) + col) = 0;
    } else {
        *(*(path + row) + col) /= 10;
    }
    return false;
}

void searchPuzzle(char **arr, char *word) {
    bool wordFound = false;

    // Capitalize the word if necessary (assuming your capitalizeWord function works as expected)
    word = capitalizeWord(word);

    int size = getMatrixSize(arr);  // Get the size of the board

    // Create a path array to keep track of the search path
    int **path = (int**)malloc(size * sizeof(int*));
    for (int i = 0; i < size; i++) {
        *(path + i) = (int*)malloc(size * sizeof(int));
        memset(*(path + i), 0, size * sizeof(int));  // Initialize path to 0
    }

    // Start searching for the word in the grid
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            // If the first letter matches, start a DFS search
            if (*(*(arr + i) + j) == *word && dfs(arr, word, i, j, 0, path)) {
                wordFound = true;
                break;
            }
        }
        if (wordFound) break;  // Exit outer loop if word is found
    }

    // Print "Word found" and the path if the word is found
    if (wordFound) {
        printf("Word found\n");
        printf("Printing the search path:\n");
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                printf("%d ", *(*(path + i) + j));  // Print path with spaces between values
            }
            printf("\n");  // Newline after each row for clear grid format
        }
    } else {
        printf("Word not found!\n");
    }

    // Free the path array memory
    for (int i = 0; i < size; i++) {
        free(*(path + i));
    }
    free(path);
}
