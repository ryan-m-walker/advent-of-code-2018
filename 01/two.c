#include <stdio.h>
#include <stdlib.h>

/* Open-addressing hash set for the frequencies we have already seen. */
#define TABLE_SIZE 1048576 /* power of two, so we can mask instead of modulo */
#define TABLE_MASK (TABLE_SIZE - 1)

static long *keys;
static char *used;

/* Returns 1 if value was already present, 0 if it was newly inserted. */
static int seen(long value) {
    unsigned long slot = (unsigned long)value & TABLE_MASK;
    while (used[slot]) {
        if (keys[slot] == value) {
            return 1;
        }
        slot = (slot + 1) & TABLE_MASK;
    }
    used[slot] = 1;
    keys[slot] = value;
    return 0;
}

int main(void) {
    FILE *fh = fopen("input.txt", "r");
    if (fh == NULL) {
        perror("Could not open input.txt");
        return 1;
    }

    long *shifts = NULL;
    size_t count = 0, capacity = 0;
    long shift;
    while (fscanf(fh, "%ld", &shift) == 1) {
        if (count == capacity) {
            capacity = capacity ? capacity * 2 : 1024;
            shifts = realloc(shifts, capacity * sizeof(long));
        }
        shifts[count++] = shift;
    }
    fclose(fh);

    keys = malloc(TABLE_SIZE * sizeof(long));
    used = calloc(TABLE_SIZE, sizeof(char));

    long total = 0;
    seen(total); /* the starting frequency of 0 counts as seen */

    /* The list may need to be cycled through more than once before a
       frequency repeats, so keep looping until we find a duplicate. */
    for (;;) {
        for (size_t i = 0; i < count; i++) {
            total += shifts[i];
            if (seen(total)) {
                printf("%ld\n", total);
                free(shifts);
                free(keys);
                free(used);
                return 0;
            }
        }
    }
}
