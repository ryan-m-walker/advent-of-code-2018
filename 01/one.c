#include <stdio.h>

int main(void) {
    FILE *fh = fopen("input.txt", "r");
    if (fh == NULL) {
        perror("Could not open input.txt");
        return 1;
    }

    long total = 0;
    long shift;
    while (fscanf(fh, "%ld", &shift) == 1) {
        total += shift;
    }

    fclose(fh);

    printf("%ld\n", total);
    return 0;
}
