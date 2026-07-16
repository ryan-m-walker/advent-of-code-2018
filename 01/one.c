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
    // read each signed shift and add it to the running total
    while (fscanf(file, "%ld", &shift) == 1) {
        total += shift;
    }

    fclose(file);
    printf("%ld\n", total);
    return 0;
}
