#include <stdio.h>
#include <string.h>

int main(void) {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        perror("Could not open input.txt");
        return 1;
    }

    long twos = 0;
    long threes = 0;

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        int counts[256] = {0};
        for (const char *c = line; *c && *c != '\n'; c++) {
            counts[(unsigned char)*c]++;
        }

        int has_two = 0;
        int has_three = 0;
        for (int i = 0; i < 256; i++) {
            if (counts[i] == 2) {
                has_two = 1;
            }
            if (counts[i] == 3) {
                has_three = 1;
            }
        }

        twos += has_two;
        threes += has_three;
    }

    fclose(file);

    printf("%ld\n", twos * threes);
    return 0;
}
