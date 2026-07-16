#include <stdio.h>

int main(void) {
  FILE *file = fopen("input.txt", "r");
  if (file == NULL) {
    perror("input.txt");
    return 1;
  }

  /* sum every frequency shift into a running total */
  long total = 0;
  int shift;
  while (fscanf(file, "%d", &shift) == 1) {
    total += shift;
  }

  fclose(file);
  printf("%ld\n", total);
  return 0;
}
