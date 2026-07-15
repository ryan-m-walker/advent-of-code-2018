#include <stdio.h>
#include <stdlib.h>

int main(void) {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        perror("Could not open input.txt");
        return 1;
    }

    long total = 0;
    long shift;
    while (fscanf(file, "%ld", &shift) == 1) {
        total += shift;
    }

    fclose(file);

    printf("%ld\n", total);
    return 0;
}
