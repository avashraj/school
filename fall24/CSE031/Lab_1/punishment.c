#include <stdio.h>

int main(int argc, char *argv[]) {

  int count, typoline;
  char punishment[] = "Coding with C is awesome!";
  char typo[] = "Cading wiht is C avesone!";

  printf("Enter the repetition count for the punishment phrase: ");
  scanf("%d",&count);

  while (count < 1) {
    printf("You entered an invalid value for the repetition count! Please re-enter: ");
    scanf("%d", &count);
  }

  printf("\nEnter the line where you want to insert the typo: ");
  scanf("%d",&typoline);

  while (typoline > count || typoline < 1) {
    printf("You entered an invalid value for the typo placement! Please re-enter: ");
    scanf("%d", &typoline);
  }

  if (typoline == 1) {
    printf("\n"); 
    printf("%s\n",typo);

    for (int i = 0; i < count - typoline; i++) {
      printf("%s\n", punishment);
    }

  } else if (count - typoline == 0){
    printf("\n"); 
     for (int i = 0; i < count - 1; i++) {
      printf("%s\n", punishment);
    }  
    printf("%s\n", typo);

  } else {
      printf("\n");
      for (int j = 0; j < typoline - 1; j++) {
        printf("%s\n", punishment);
      }

      printf("%s\n",typo);

      for (int j = 0; j < count - typoline; j++) {
        printf("%s\n",punishment);
      }
  }

}
