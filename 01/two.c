#include <stdio.h>
#include <stdlib.h>

#define HASH_SIZE 1000003

typedef struct Node {
    long value;
    struct Node *next;
} Node;

static Node *buckets[HASH_SIZE];

static size_t hash(long value) {
    unsigned long key = (unsigned long)value;
    return (size_t)(key % HASH_SIZE);
}

static int seen_add(long value) {
    size_t index = hash(value);
    for (Node *node = buckets[index]; node; node = node->next) {
        if (node->value == value) {
            return 1;
        }
    }

    Node *node = malloc(sizeof(Node));
    node->value = value;
    node->next = buckets[index];
    buckets[index] = node;
    return 0;
}

int main(void) {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        perror("Could not open input.txt");
        return 1;
    }

    size_t capacity = 16;
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

    long total = 0;
    while (1) {
        for (size_t i = 0; i < count; i++) {
            if (seen_add(total)) {
                printf("%ld\n", total);
                free(shifts);
                return 0;
            }
            total += shifts[i];
        }
    }
}
