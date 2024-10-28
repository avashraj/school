#include <stdio.h>
#include <stdlib.h>

struct Node {
    int iValue;
    float fValue;
    struct Node *next;
};

int main() {

    struct Node *head = (struct Node*) malloc(sizeof(struct Node));
    head->iValue = 5;
    head->fValue = 3.14;
	
	// Insert code here
  printf("head value: %d", head->iValue);	
  printf("\nhead address: %p", &head);
  printf("\niValue address: %p", &head->iValue);
  printf("\nfValue address: %p",&head->fValue); 
  printf("\nnext ptr value: %p", &head->next);



	
	return 0;
}
