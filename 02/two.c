#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        perror("Could not open input.txt");
        return 1;
    }

    size_t capacity = 16;
    size_t count = 0;
    char **ids = malloc(capacity * sizeof(char *));

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        line[strcspn(line, "\n")] = '\0';
        if (line[0] == '\0') {
            continue;
        }
        if (count == capacity) {
            capacity *= 2;
            ids = realloc(ids, capacity * sizeof(char *));
        }
        ids[count++] = strdup(line);
    }

    fclose(file);

    for (size_t i = 0; i < count; i++) {
        for (size_t j = i + 1; j < count; j++) {
            size_t len = strlen(ids[i]);
            size_t diff = 0;
            size_t diff_index = 0;
            for (size_t k = 0; k < len; k++) {
                if (ids[i][k] != ids[j][k]) {
                    diff++;
                    diff_index = k;
                }
            }

            if (diff == 1) {
                for (size_t k = 0; k < len; k++) {
                    if (k != diff_index) {
                        putchar(ids[i][k]);
                    }
                }
                putchar('\n');
                for (size_t m = 0; m < count; m++) {
                    free(ids[m]);
                }
                free(ids);
                return 0;
            }
        }
    }

    for (size_t m = 0; m < count; m++) {
        free(ids[m]);
    }
    free(ids);
    return 1;
}
