#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// open addressed hash set of the frequencies we have already reached. the
// capacity is always a power of two so an index can be masked out of a hash
typedef struct {
    long *keys;
    bool *used;
    size_t capacity;
    size_t count;
} FreqSet;

static size_t hash_index(const FreqSet *set, long key) {
    // knuth's multiplicative hash, scrambled enough for the mostly
    // sequential totals we feed it
    unsigned long hash = (unsigned long)key * 2654435761UL;
    return (size_t)hash & (set->capacity - 1);
}

static void freq_set_init(FreqSet *set, size_t capacity) {
    set->keys = malloc(capacity * sizeof(*set->keys));
    set->used = calloc(capacity, sizeof(*set->used));
    if (set->keys == NULL || set->used == NULL) {
        fprintf(stderr, "out of memory\n");
        exit(EXIT_FAILURE);
    }
    set->capacity = capacity;
    set->count = 0;
}

static void freq_set_free(FreqSet *set) {
    free(set->keys);
    free(set->used);
}

static void freq_set_grow(FreqSet *set);

// insert a frequency and report whether it was already in the set
static bool freq_set_add(FreqSet *set, long key) {
    // keep the load factor under half so probe runs stay short
    if ((set->count + 1) * 2 > set->capacity) {
        freq_set_grow(set);
    }

    size_t index = hash_index(set, key);
    while (set->used[index]) {
        if (set->keys[index] == key) {
            return true;
        }
        index = (index + 1) & (set->capacity - 1);
    }

    set->used[index] = true;
    set->keys[index] = key;
    set->count++;
    return false;
}

static void freq_set_grow(FreqSet *set) {
    FreqSet grown;
    freq_set_init(&grown, set->capacity * 2);

    for (size_t i = 0; i < set->capacity; i++) {
        if (set->used[i]) {
            freq_set_add(&grown, set->keys[i]);
        }
    }

    freq_set_free(set);
    *set = grown;
}

int main(void) {
    FILE *file = fopen("input.txt", "r");
    if (file == NULL) {
        perror("input.txt");
        return EXIT_FAILURE;
    }

    size_t capacity = 1024;
    size_t length = 0;
    long *shifts = malloc(capacity * sizeof(*shifts));
    if (shifts == NULL) {
        fprintf(stderr, "out of memory\n");
        return EXIT_FAILURE;
    }

    long shift;
    while (fscanf(file, "%ld", &shift) == 1) {
        if (length == capacity) {
            capacity *= 2;
            long *resized = realloc(shifts, capacity * sizeof(*shifts));
            if (resized == NULL) {
                fprintf(stderr, "out of memory\n");
                return EXIT_FAILURE;
            }
            shifts = resized;
        }
        shifts[length++] = shift;
    }

    fclose(file);

    if (length == 0) {
        fprintf(stderr, "no frequency shifts found in input.txt\n");
        free(shifts);
        return EXIT_FAILURE;
    }

    FreqSet seen;
    freq_set_init(&seen, 1 << 16);

    long total = 0;
    freq_set_add(&seen, total);

    // cycle over the shifts until a total repeats. the list is guaranteed to
    // be walked more than once for any real input
    for (;;) {
        for (size_t i = 0; i < length; i++) {
            total += shifts[i];
            if (freq_set_add(&seen, total)) {
                printf("%ld\n", total);
                freq_set_free(&seen);
                free(shifts);
                return EXIT_SUCCESS;
            }
        }
    }
}
