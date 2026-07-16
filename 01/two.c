#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

// Open-addressing hash set for the frequencies we've already seen.
#define TABLE_SIZE (1 << 20) // power of two so we can mask instead of modulo
#define EMPTY LONG_MIN

static long *table;

static size_t hash_index(long value) {
    // multiplicative hash, then mask to the table size
    unsigned long h = (unsigned long)value * 2654435761UL;
    return (size_t)(h & (TABLE_SIZE - 1));
}

// returns 1 if the value was already present, 0 if it was newly inserted
static int seen(long value) {
    size_t i = hash_index(value);
    while (table[i] != EMPTY) {
        if (table[i] == value) {
            return 1;
        }
        i = (i + 1) & (TABLE_SIZE - 1);
    }
    table[i] = value;
    return 0;
}

int main(void) {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        perror("Could not open input.txt");
        return 1;
    }

    // read all the shifts into a dynamically grown array
    size_t capacity = 1024;
    size_t count = 0;
    long *shifts = malloc(capacity * sizeof(long));
    long shift;
    while (fscanf(file, "%ld", &shift) == 1) {
        if (count == capacity) {
            capacity *= 2;
            shifts = realloc(shifts, capacity * sizeof(long));
        }
        shifts[count++] = shift;
    }
    fclose(file);

    table = malloc(TABLE_SIZE * sizeof(long));
    for (size_t i = 0; i < TABLE_SIZE; i++) {
        table[i] = EMPTY;
    }

    // loop over the shifts repeatedly until a total repeats
    long total = 0;
    long found = 0;
    int done = 0;
    while (!done) {
        for (size_t i = 0; i < count; i++) {
            if (seen(total)) {
                found = total;
                done = 1;
                break;
            }
            total += shifts[i];
        }
    }

    printf("FOUND: %ld\n", found);

    free(shifts);
    free(table);
    return 0;
}
