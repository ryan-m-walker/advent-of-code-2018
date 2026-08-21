#include <stdio.h>
#include <stdlib.h>

int main(void) {
    FILE *file = fopen("input.txt", "r");
    if (file == NULL) {
        perror("input.txt");
        return EXIT_FAILURE;
    }

    long total = 0;
    long shift;

    // each line is a signed number like "+3" or "-15" which scanf reads directly
    while (fscanf(file, "%ld", &shift) == 1) {
        total += shift;
    }

    fclose(file);

    printf("%ld\n", total);
    return EXIT_SUCCESS;
}
