#include <stdio.h>

//sumofdigits sums up given number by modulo 10 and dividing by ten until the number is less than 0
int sumofdigits(int num) {

  int sum = 0;

  if (num < 0) {
    num = num * -1;
  }

  while (num > 0) { 
    sum = sum + (num % 10);
    num = num / 10;
  }

  return sum;
}

//correctsuffix returns the correct suffix based on the number it is provided
char* correctsuffix(int num) {

  char st[] = "st";
  char nd[] = "nd";
  char rd[] = "rd";
  char th[] = "th";

 if (num % 100 == 11 ||
     num % 100 == 12 ||
     num % 100 == 13) {

    return "th";
  } else {

    int num2 = num % 10;
    
    if (num2 == 1) {
      return "st";

    } else if (num2 == 2) {
      return "nd";

    } else if (num2 == 3) {
      return "rd";

    } else {
      return "th";
    }
  }
}

//main logic here
//calculates the averages of numbers summing to even and odd numbers
void averagingbysum() {

  int oddsum = 0; int evensum = 0;
  int oddcount = 0; int evencount = 0;
  int printcount = 1; int input = 1;
  
  while (input != 0) {

    printf("Enter the %d%s %s", printcount, correctsuffix(printcount), "value: ");
    scanf("%d", &input);

    if (input == 0) {
      break;
    }

    int sum = sumofdigits(input);
    
    if (sum % 2 == 0) {
      evensum = evensum + input;
      evencount ++;

    } else {
      oddsum = input + oddsum;
      oddcount ++;
    }

    printcount ++;

  }
  
  if (oddsum == 0 && evensum == 0 && input == 0) {
    printf("\nThere is no average to compute.");
    return;
  }
  if (oddsum == 0) {
    
    printf("\nAverage of input values whose digits sum to an even number: %.2f", (float)evensum / evencount);
  } else if (evensum == 0) {
    printf("\nAverage of input values whose digits sum to an odd number: %.2f", (float)oddsum / oddcount);

  } else {
    printf("\nAverage of input values whose digits sum to an even number: %.2f", (float)evensum / evencount);
    printf("\nAverage of input values whose digits sum to an odd number: %.2f", (float)oddsum / oddcount);
  }
}

int main(int argc, char *argv[]) {
  averagingbysum(); 
  return 0;
}
